class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :title
      t.string :description
      t.integer :parent_board_id
      t.boolean :locked

      t.timestamps
    end
  end
end
