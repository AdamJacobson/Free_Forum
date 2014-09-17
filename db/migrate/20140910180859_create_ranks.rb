class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.string :title
      t.string :color
      t.integer :requirement
      t.boolean :system, :default => false

      t.timestamps
    end
  end
end
