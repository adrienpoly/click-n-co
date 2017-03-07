require 'open-uri'
require 'byebug'
require 'awesome_print'
require 'json'
require 'uri'
require 'yaml'
require 'nokogiri'



class Scrap
  def scrap(keyword)
    url = @base_url + @search_string + keyword
    @results = []
    byebug
    doc = Nokogiri::HTML(open(url), nil, 'utf-8')
    doc.search(@items_list[:elements]).each do |element|
      hash = {}
      # @items_path.each { |key, value| hash[key] = element.search(value).text.strip }
      @items_url.each { |key, value| hash[key] = @base_url + element.search(value).attr('href') }
      @results << hash.merge!(scrap_full_details(hash[:url]))
    end
    @results
  end

  def scrap_full_details(url)
    p url
    doc = Nokogiri::HTML(open(url), nil, 'utf-8')
    doc.encoding = 'utf-8'
    hash = {}
    # byebug
    @detail_path.each { |key, value| hash[key] = doc.search(value).inner_html }

    @detail_image.each { |key, value| hash[key] = @base_url + doc.xpath("//*[@data-src]").attr('data-src').value unless doc.xpath("//*[@data-src]").empty? }

    # @detail_image.each { |key, value| hash[key] = doc.search(value).attr('data-src') unless doc.search(value).empty? }
    hash
  end

  def all
    @results
  end

  def to_s
    str = ""
    @results.each_with_index do |hash, index|
      str << "#{index} \n"
      hash.each { |key, value| str += "#{key} : #{value}\n" }
      str << "\n"
    end
    str
  end
end

class ScrapYelp < Scrap
  def initialize(search_string)
    @base_url = "https://www.yelp.fr/search?find_loc=Bordeaux&"

    @search_string = search_string
    # @search_string = ""

    scraping_rules_for_list
    scraping_rules_for_detail
  end

  def scraping_rules_for_list
    @items_list = { elements: '.indexed-biz-name>a' }

    # @items_path = {
    #   name: '.m_titre_resultat',
    #   short_description: '.m_texte_resultat'
    # }

    @items_url = { url: 'a' }
  end

  def scraping_rules_for_detail
    # @items_list = { elements: '.recette_classique' }

    @detail_image = { image_url: '#slide' }
    @detail_path = {
      name: '#home h2',
      description: '.col-sm-7 p',
      installations: '.fadeInRight li',
      address: '#home h3'
    }
  end
end

# https://www.yelp.fr/search?find_loc=Bordeaux&start=10&cflt=cheese

# list_of_url = [
#   "start=0&cflt=cheese",
#   "start=10&cflt=cheese",
#   "start=20&cflt=cheese",
#   "start=30&cflt=cheese",
#   "start=40&cflt=cheese"]

list_of_url = [
  "start=0&cflt=cheese"]
byebug
open('https://www.yelp.com/biz/jean-d-alos-bordeaux-2?adjust_creative=YE6j_U8K3vzG9regkPEXQQ&utm_campaign=yelp_api_v3&utm_medium=api_v3_business_search&utm_source=YE6j_U8K3vzG9regkPEXQQ',
  "User-Agent" => "Ruby/#{RUBY_VERSION}",
    "From" => "foo@bar.invalid",
    "Referer" => "http://www.ruby-lang.org/")

scrap = []
list_of_url.each do |url|
  p url
  scrap << ScrapYelp.new(url).scrap('')
end
scrap.flatten!

# File.open("raw-scrap-data.json","w") do |f|
#   f.write(JSON.pretty_generate(scrap))




# base_url_maps = "https://maps.googleapis.com/maps/api/geocode/json?key=#{key['GOOGLE_MAPS']}&components=country:FR&region=fr&address="
# scrap_with_address = []
# scrap.each do |spa|
#   url =  URI.escape(base_url_maps + (spa['name'] + ' ' + spa['address'].gsub(/[0-9]/,'')).strip.downcase.tr('*',''))
#   data = JSON.load(open(url))
#   if data['status'] != 'OK'
#     p 'retry'
#     url =  URI.escape(base_url_maps + spa['name'].downcase.tr('*',''))
#     data = JSON.load(open(url))
#   end
#   p url
#   break if data['status'] != 'OK'
#   spa[:raw_google_maps] = data
#   spa[:amenities] = {
#     'installations': spa['installations'].scan(/(\d\sx\s\D+)/).flatten,
#     'equipments': spa['equipments'].scan(/(\d\sx\s\D+)/).flatten
#    }
#   spa[:lat] = data['results'][0]['geometry']['location']['lat']
#   spa[:lng] = data['results'][0]['geometry']['location']['lng']
#   p spa[:address] = data['results'][0]['formatted_address']
#   scrap_with_address << spa
# end


# File.open("scrap-data.json","w") do |f|
#   f.write(JSON.pretty_generate(scrap_with_address))
# end

