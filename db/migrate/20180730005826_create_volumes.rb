class CreateVolumes < ActiveRecord::Migration[5.2]
  def change
    create_table :volumes do |t|
      t.integer :value
      t.string :unit

      t.timestamps
    end
  end
end
