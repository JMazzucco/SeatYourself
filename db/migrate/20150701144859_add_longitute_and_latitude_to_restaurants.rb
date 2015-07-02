class AddLongituteAndLatitudeToRestaurants < ActiveRecord::Migration
  def change
  	add_column :restaurants, :Longitute, :decimal, precision: 9, scale: 6
  	add_column :restaurants, :Latitude, :decimal, precision: 9, scale: 6
  end
end
