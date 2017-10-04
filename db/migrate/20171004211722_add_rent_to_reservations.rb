class AddRentToReservations < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :rent, :float
  end
end
