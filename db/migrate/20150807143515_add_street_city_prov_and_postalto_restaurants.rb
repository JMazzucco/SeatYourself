class AddStreetCityProvAndPostaltoRestaurants < ActiveRecord::Migration
 	def change
    add_column :restaurants, :street, :string
    add_column :restaurants, :city, :string
    add_column :restaurants, :prov, :string
    add_column :restaurants, :postal, :string
  end
end
