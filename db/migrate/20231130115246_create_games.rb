class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :title
      t.string :platform
      t.text :description
      t.string :genre
      t.decimal :price
      t.string :esrb_rating
      t.string :manufacturer
      t.date :release_date
      t.string :weight
      t.integer :stock

      t.timestamps
    end
  end
end
