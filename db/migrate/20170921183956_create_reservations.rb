class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.references :user, foreign_key: true
      t.references :car, foreign_key: true
      t.datetime :check_out
      t.datetime :return
      t.boolean :checked_out
      t.boolean :returned

      t.timestamps
    end
  end
end
