class ChangeTimeInReservations < ActiveRecord::Migration
  def up
    change_column :reservations, :longitute, :decimal
    change_column :reservations, :latitude, :decimal
  end

  def down
    change_column :reservations, :Longitute, :decimal
    change_column :reservations, :Latitude, :decimal
  end
end
