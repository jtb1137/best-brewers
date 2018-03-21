class CreateBreweries < ActiveRecord::Migration[5.1]
  def change
    create_table :breweries do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zipcode

      t.timestamps
    end
  end
end
