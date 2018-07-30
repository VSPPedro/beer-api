class AddBeerToCreator < ActiveRecord::Migration[5.2]
  def change
    add_reference :creators, :beer, foreign_key: true
  end
end
