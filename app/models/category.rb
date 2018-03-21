class Category < ApplicationRecord
    has_many :brewery_categories
    has_many :breweries, through: :brewery_categories
end
