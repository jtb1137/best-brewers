class BreweryCategory < ApplicationRecord
    belongs_to :brewery
    belongs_to :category
end
