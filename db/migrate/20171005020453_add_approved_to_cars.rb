class AddApprovedToCars < ActiveRecord::Migration[5.1]
  def change
    add_column :cars, :approved, :boolean, default:false
  end
end
