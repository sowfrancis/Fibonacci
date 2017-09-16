class CreateTechnicalInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :technical_infos do |t|
      t.string :pdl
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
