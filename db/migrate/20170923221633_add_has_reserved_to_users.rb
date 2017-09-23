class AddHasReservedToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :has_reserved, :boolean, default: false
  end
end
