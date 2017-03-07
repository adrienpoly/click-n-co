class Shop < ApplicationRecord
  include PgSearch

  belongs_to :user
  belongs_to :category

  has_many :opening_hours
  has_many :products
  has_many :orders

  validates :name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  geocoded_by :address

  after_validation :geocode, if: :address_changed?
  has_many :product_categories, through: :products
  has_attachment :photo
  after_create :set_owner


  belongs_to :cracker
  has_many :cheeses, :through => :cracker

  pg_search_scope :search_products_shops,
    associated_against: {
      products: [ :name, :short_description, :description ]
    }

  def to_hash
    categories = self.product_categories.distinct
    hash = {}
    categories.each do |category|
      products = self.products.where(product_category: category)
      hash[category.name] = products
    end
    hash
  end
  private

  def set_owner
    self.user.owner! unless self.user.owner?
  end
end

