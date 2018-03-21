class AddSubmittedByToBreweries < ActiveRecord::Migration[5.1]
  def change
    add_column :breweries, :submitted_by, :integer
  end
end
