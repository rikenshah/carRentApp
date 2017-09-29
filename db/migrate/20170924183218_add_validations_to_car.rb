class AddValidationsToCar < ActiveRecord::Migration[5.1]
  def change
    change_column :cars, :status, :string, :default => 'available'
  end
end
