class AddCanCheckOutToReservation < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :can_checkout, :boolean, :default => false
    add_column :reservations, :can_return, :boolean, :default => false
  end
end
