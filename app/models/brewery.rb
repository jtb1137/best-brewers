class Brewery < ApplicationRecord
    
    has_attached_file :image, styles: { medium: "900x400#", thumb: "286x180#" }, default_url: "http://via.placeholder.com/286x180",
        convert_options: {:medium => "-gravity center -extent 900x400", :thumb => "-gravity center -extent 286x180"}
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/


    has_many :brewery_categories
    has_many :categories, through: :brewery_categories
    accepts_nested_attributes_for :categories, reject_if: proc { |attribute| attribute['name'] === "" }
    has_many :favorite_breweries
    has_many :favorited_by, through: :favorite_breweries, source: :user
    has_many :reviews

    #geocoded_by :full_address
    #after_validation :geocode

    def full_address
        [address1, address2, city, state, zipcode].join(', ')
    end

    scope :newest, -> { order("created_at DESC").limit(25) }
    scope :oldest, -> { order("created_at ASC").limit(25) }

    def categories_attributes=(category_attributes)
        
        category_attributes.values.each do |attribute|
            if attribute["name"] != ""
                category = Category.find_or_create_by(attribute)
                self.categories << category 
            end
        end
    end

    #def self.search(params)
    #    restaurants = Restaurant.where("name LIKE ?", "%#{params[:search]}%")
    #    restaurants = restaurants.near(params[:location]) if params[:location].present?
    #    restaurants
    #end

end