class Order < ApplicationRecord
  has_many :ordered_products, dependent: :destroy
  belongs_to :user
  belongs_to :shop
  enum status: [:confirmed, :pending, :processing, :ready, :picked_up, :canceled]
  # enum status: {
  #   :pending => 1,
  #   :processing => 2,
  #   :confirmed => 3,
  #   :ready => 4,
  #   :picked_up => 5,
  #   :canceled => 6
  # }
  # #[:en_attente, :en_cours_de_préparation, :commande_prête, :commande_récupérée, :commande_annulée]
  monetize :total_price_cents

  def self.human_enum_name(enum_name, enum_value)
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.#{enum_name.to_s.pluralize}.#{enum_value}")
  end
end











