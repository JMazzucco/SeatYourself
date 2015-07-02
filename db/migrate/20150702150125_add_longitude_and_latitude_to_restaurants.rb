class AddLongitudeAndLatitudeToRestaurants < ActiveRecord::Migration
  def change
  	add_column :restaurants, :longitude, :decimal, precision: 9, scale: 6
  	add_column :restaurants, :latitude, :decimal, precision: 9, scale: 6
  end
end
