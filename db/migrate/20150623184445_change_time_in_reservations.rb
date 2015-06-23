class ChangeTimeInReservations < ActiveRecord::Migration
  def up
    change_column :reservations, :time, :datetime
  end

  def down
    change_column :reservations, :time, :integer
  end
end
