class CreateSituations < ActiveRecord::Migration[5.0]
  def change
    create_table :situations do |t|
      t.boolean :move_in
      t.boolean :new_house
      t.boolean :new_access
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
