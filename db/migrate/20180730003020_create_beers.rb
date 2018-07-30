class CreateBeers < ActiveRecord::Migration[5.2]
  def change
    create_table :beers do |t|
      t.string :name
      t.string :description
      t.datetime :fabrication

      t.timestamps
    end
  end
end
