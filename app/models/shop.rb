class Shop < ApplicationRecord
  include PgSearch

  belongs_to :user
  belongs_to :category

  has_many :opening_hours, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :product_categories, through: :products
  has_attachment :photo

  validates :name, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :name, uniqueness: true

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  after_create :set_owner

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

  def self.search_by_address(params)
    if params[:category].nil? || params[:category].empty?
      params[:where].blank? ? shops = Shop.all.page(params[:page]) : shops = Shop.near(params['where'], 1000).page(params[:page])
    else
      params[:where].blank? ? shops = Shop.where(category_id: params[:category]).page(params[:page]) : shops = Shop.near(params['where'], 1000).where(category_id: params[:category]).page(params[:page])
    end
    shops
  end

  def self.search_by_latlng(params)
    dist = params[:dist] || 5
    latlng = [params[:lat], params[:lng]] || [44.84044, -0.5805]
    category_id = Category.find_by name: params[:category].capitalize
    shops = Shop.near(latlng, dist).where(category_id: category_id)
  end

  private

  def set_owner
    self.user.owner! unless self.user.owner?
  end
end

