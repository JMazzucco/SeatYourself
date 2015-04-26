class AddPartySizeToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :party_size, :integer
  end
end
