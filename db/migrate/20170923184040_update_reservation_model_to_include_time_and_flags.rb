class UpdateReservationModelToIncludeTimeAndFlags < ActiveRecord::Migration[5.1]
  def up
  	change_column :reservations, :check_out, :datetime
  	change_column :reservations, :return, :datetime
  	change_column :reservations, :checked_out, :boolean, default: false
  	change_column :reservations, :returned, :boolean, default: false
  end

  def down
  	change_column :reservations, :check_out, :boolean
  	change_column :reservations, :return, :boolean
  	change_column :reservations, :checked_out, :boolean, default: nil
  	change_column :reservations, :returned, :boolean, default: nil
  end
end
