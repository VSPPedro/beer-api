class CreateBeerVolumes < ActiveRecord::Migration[5.2]
  def change
    create_table :beer_volumes do |t|
      t.references :beer, foreign_key: true
      t.references :volume, foreign_key: true

      t.timestamps
    end
  end
end
