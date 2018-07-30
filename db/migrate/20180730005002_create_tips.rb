class CreateTips < ActiveRecord::Migration[5.2]
  def change
    create_table :tips do |t|
      t.string :description
      t.references :beer, foreign_key: true

      t.timestamps
    end
  end
end
