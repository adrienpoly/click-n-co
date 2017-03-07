class Order < ApplicationRecord
  has_many :ordered_products, dependent: :destroy
  belongs_to :user
  belongs_to :shop
  #enum status: [:pending, :confirmed, :ready, :picked_up, :canceled]
  enum status: {
    :attente => 1,
    :préparation => 2,
    :prête => 3,
    :récupérée => 4,
    :annulée => 5
  }
  #[:en_attente, :en_cours_de_préparation, :commande_prête, :commande_récupérée, :commande_annulée]
  monetize :total_price_cents

end







