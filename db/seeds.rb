Product.destroy_all
ProductCategory.destroy_all
Shop.destroy_all
User.destroy_all

owner = User.new(email: 'adrienpoly@gmail.com', password: '123456')
owner.save

user = User.new(email: 'lucie.lasagna@essec.edu', password: '123456')
user.save

p "google API key " + ENV['GOOGLE_MAPS']

shop = Shop.new(name: "LA CARAVELLE DES SAVEURS",
  description: "Après avoir longtemps travaillé dans le milieu de la Mode, Paula s’est reconvertie avec succès dans le monde de la gastronomie. Fière de ses origines portugaises, elle souhaitait pouvoir faire découvrir les nombreuses spécialités du pays de ses parents et c’est chose faite depuis 2015 avec cette épicerie fine de qualité !",
  address: "12, rue du Faubourg Saint-Martin 75010 Paris",
  phone_number: "01 98 98 98 98",
  category: "111 Epicerie")
shop.user = owner
shop.save!
puts shop.name
shop = Shop.new(name: "FROMAGERIE LÉAUTEY",
  description: "Large gamme de fromages : faîtes votre choix parmi près de 400 variétés!
    Ici, on fait la part belle aux fromages français! Vache, chèvre, brebis… Il y en a pour tous les goûts !
    Quelques variétés de fromages étrangers comme le pecorino à la truffe, la burrata…",
  address: "81, avenue de Saint-Ouen 75017 Paris",
  phone_number: "01 01 98 99 98",
  category: "112 Crémerie")
shop.user = owner
shop.save!
puts shop.name
shop = Shop.new(name: "BOUCHERIE DES GRAVILLIERS",
  description: "Boucherie Charcuterie Traiteur,  100\% artisanal
    Boucherie : côtes de bœuf, rosbifs, biftecks… Races de viande de qualité : Blonde d’Aquitaine, Parthenaise, Limousine. Mais aussi côtes de porc, rôtis de porc, brochettes de veau / bœuf / agneau des Pays d’Oc…
    Charcuterie : jambon blanc Maison, rillettes de porc, terrines de campagne  100\% Maison (lapin, canard…), chipolatas, saucisses de Toulouse, merguez…",
  address: "28, rue des Gravilliers 75003 Paris",
  phone_number: "01 99 98 99 98",
  category: "121 Boucherie - Charcuterie")
shop.user = owner
shop.save!
puts shop.name
shop = Shop.new(name: "LES PETITS MITRONS",
  description: "Entre 10 et 15 variétés de tartes sucrées, LA spécialité Maison, disponible en 3 tailles
    Large choix de tartes salées, quiches et pizzas, pour se faire plaisir sur le pouce ou à table
    Des cookies à tomber par terre (chocolat noir, blanc, caramel, figues-raisins, noix de pécan, pistache, cranberry…)
    Des viennoiseries Maison (croissants, pains au chocolat, chaussons aux pommes, brioches…)
    Belle gamme de confitures et miel et sucreries pour les petits et grands enfants",
  address: "26, rue Lepic 75018 Paris",
  phone_number: "01 98 01 98 01",
  category: "130 Boulangerie - Pâtisserie sans salon de consommation")
shop.user = owner
shop.save!
puts shop.name
shop = Shop.new(name: "LE CHAMP DES RÊVES",
  description: "Primeur : fruits et légumes 100\% de saison, issus principalement de l’agriculture biologique et biodynamique (Label Demeter)
    Produits en circuits courts, en direct de petits producteurs ou coopératives d’Île-de-France et des régions voisines (Picardie, Normandie, Bretagne, Centre) !",
  address: "25, rue de la Jonquière 75017 Paris",
  phone_number: "01 01 01 98 99",
  category: "114 Primeurs")
shop.user = owner
shop.save!
puts shop.name
shop = Shop.new(name: "CÔTÉ CÉPAGE",
  description: "Vins gourmands, opulents ou astringents : il y en a pour tous les goûts !
    Vins de pays et vins AOC
    Vins de petits domaines (visités par Nicole !) : Mas de l’Oncle, Domaine des Homs, Domaine du Château la Borie…
    Vins pétillants (Crémant de Bourgogne…) et Champagnes (Veuve Fourny et Joseph Perrier)
    Spiritueux (Cognac, Armagnac, Bas-Armagnac, whiskys…)",
  address: "96, rue Legendre 75017 Paris",
  phone_number: "01 20 01 01 98",
  category: "140 Liqueurs - Vins")
shop.user = owner
shop.save!
puts shop.name




categories = ["Plateaux Apéro", "Plateaux Découverte", "Portions", "Extras",
  "Vins", "Champagnes"]

categories.each do |categorie|
  ProductCategory.create(name: categorie)
end

def read_csv
  products = []
  csv_options = { col_sep: ';', quote_char: '"', headers: true, header_converters: :symbol }
  CSV.foreach('db/products.csv', csv_options) do |row|
    params = row.to_hash.delete_if { |key, _value| key.nil? }
    products << params
  end
  products
end

products = read_csv
shops = Shop.all
shops.each do |shop|
  products.each do |product|
    product_category = ProductCategory.where(name: product[:product_category]).first
    new_product = Product.new()
    new_product.name = product[:name]
    new_product.short_description = product[:short_description]
    new_product.price = product[:price]
    new_product.product_category = product_category
    new_product.shop = shop
    new_product.save
  end

end
