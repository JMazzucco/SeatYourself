class RemoveLongitudeAndLatitudeFromRestaurants < ActiveRecord::Migration
  def change
  	remove_column(:restaurants, :Longitute)
  	remove_column(:restaurants, :Latitude)
  end
end
