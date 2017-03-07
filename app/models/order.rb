class Order < ApplicationRecord
  has_many :ordered_products
  belongs_to :user
  belongs_to :shop
  #enum status: [:pending, :confirmed, :ready, :picked_up, :canceled]
  enum status: {
    :pending => 1,
    :processing => 2,
    :confirmed => 3,
    :ready => 4,
    :picked_up => 5,
    :canceled => 6
  }
  #[:en_attente, :en_cours_de_préparation, :commande_prête, :commande_récupérée, :commande_annulée]
end









