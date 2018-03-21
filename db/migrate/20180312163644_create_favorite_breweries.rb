class CreateFavoriteBreweries < ActiveRecord::Migration[5.1]
  def change
    create_table :favorite_breweries do |t|
      t.integer :brewery_id
      t.integer :user_id

      t.timestamps
    end
  end
end
