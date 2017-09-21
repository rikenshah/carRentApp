class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.string :status
      t.string :model
      t.string :manufacturer
      t.string :style
      t.float :rent
      t.string :location
      t.string :licence_plate

      t.timestamps
    end
  end
end
