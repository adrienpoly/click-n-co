require "json"
require "http"
require "optparse"
require 'awesome_print'
require 'byebug'

CLIENT_ID = 'YE6j_U8K3vzG9regkPEXQQ'
CLIENT_SECRET = 'lvGz8bGvcpakl6S3B8tHoKL6Uj01KHUt5FhT048nbotOrfjrc559gnavA6d2BJm2'

API_HOST = "https://api.yelp.com"
SEARCH_PATH = "/v3/businesses/search"
BUSINESS_PATH = "/v3/businesses/"  # trailing / because we append the business id to the path
TOKEN_PATH = "/oauth2/token"
GRANT_TYPE = "client_credentials"


DEFAULT_BUSINESS_ID = "yelp-san-francisco"
DEFAULT_TERM = "dinner"
DEFAULT_LOCATION = "San Francisco, CA"
SEARCH_LIMIT = 50


# Make a request to the Fusion API token endpoint to get the access token.
#
# host - the API's host
# path - the oauth2 token path
#
# Examples
#
#   bearer_token
#   # => "Bearer some_fake_access_token"
#
# Returns your access token
def bearer_token
  # Put the url together
  url = "#{API_HOST}#{TOKEN_PATH}"

  raise "Please set your CLIENT_ID" if CLIENT_ID.nil?
  raise "Please set your CLIENT_SECRET" if CLIENT_SECRET.nil?

  # Build our params hash
  params = {
    client_id: CLIENT_ID,
    client_secret: CLIENT_SECRET,
    grant_type: GRANT_TYPE
  }

  response = HTTP.post(url, params: params)
  parsed = response.parse

  "#{parsed['token_type']} #{parsed['access_token']}"
end


# Make a request to the Fusion search endpoint. Full documentation is online at:
# https://www.yelp.com/developers/documentation/v3/business_search
#
# term - search term used to find businesses
# location - what geographic location the search should happen
#
# Examples
#
#   search("burrito", "san francisco")
#   # => {
#          "total": 1000000,
#          "businesses": [
#            "name": "El Farolito"
#            ...
#          ]
#        }
#
#   search("sea food", "Seattle")
#   # => {
#          "total": 1432,
#          "businesses": [
#            "name": "Taylor Shellfish Farms"
#            ...
#          ]
#        }
#
# # Returns a parsed json object of the request
# def search(term, location, category)
#   url = "#{API_HOST}#{SEARCH_PATH}"
#   params = {
#     term: term,
#     location: location,
#     limit: SEARCH_LIMIT
#     categories: category
#   }

#   response = HTTP.auth(bearer_token).get(url, params: params)
#   response.parse
# end

def search(categorie)
  url = "#{API_HOST}#{SEARCH_PATH}"
  params = {
      location: '33400+bordeaux',
      limit: SEARCH_LIMIT,
      categories: categorie,
      radius: 15000,
      locale: 'fr_FR'
    }
  response = HTTP.auth(bearer_token).get(url, params: params)
  response.parse
end

def create_hash(results, categorie)
  result_ary = []
  results['businesses'].each do |business|
    unless business['image_url'] == ""
      result_ary << {
        address: business['location']['display_address'].join(', '),
        name: business['name'],
        category: categorie,
        image_url: business['image_url'],
        phone: business['phone'],
        url: business['url']
      }
    end
  end
  result_ary
end

shops = {}
shops['Fromagerie']               = create_hash(search('cheese'), 'Fromagerie').flatten
shops['Boucherie']                = create_hash(search('butcher,meats'), 'Boucherie').flatten
shops['Primeur']                  = create_hash(search('markets'), 'Primeur').flatten
shops['Caviste']                  = create_hash(search('beer_and_wine'), 'Caviste').flatten
shops['Boulangerie - Patisserie'] = create_hash(search('bakeries,cakeshop'), 'Boulangerie - Patisserie').flatten
shops['Poissonerie']              = create_hash(search('seafoodmarkets'), 'Poissonerie').flatten

File.open("yelp_shops.json","wb") do |f|
  f.write(JSON.pretty_generate(shops))
end


# Look up a business by a given business id. Full documentation is online at:
# https://www.yelp.com/developers/documentation/v3/business
#
# business_id - a string business id
#
# Examples
#
#   business("yelp-san-francisco")
#   # => {
#          "name": "Yelp",
#          "id": "yelp-san-francisco"
#          ...
#        }
#
# Returns a parsed json object of the request
def business(business_id)
  url = "#{API_HOST}#{BUSINESS_PATH}#{business_id}"

  response = HTTP.auth(bearer_token).get(url)
  response.parse
end

ap result = business('les-fromages-de-manon-talence')
File.open("shop-example.json","w") do |f|
   f.write(JSON.pretty_generate(result))
end
