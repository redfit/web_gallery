class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
      t.integer :bookmark_id
      t.integer :x
      t.integer :y
      t.integer :red
      t.integer :green
      t.integer :blue
      t.integer :alpha

      t.timestamps
    end
  end
end
