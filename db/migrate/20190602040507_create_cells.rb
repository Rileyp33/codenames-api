class CreateCells < ActiveRecord::Migration[5.2]
  def change
    create_table :cells do |t|
      t.belongs_to :game, null: false
      t.belongs_to :word, null: false
      t.string :color, null: false
      t.integer :position, null: false
      t.string :flipped_status, null: false
      t.timestamps
    end
  end
end
