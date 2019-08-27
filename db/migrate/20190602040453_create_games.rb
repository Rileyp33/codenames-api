class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :codename, null: false
      t.string :result
      t.timestamps
    end
  end
end
