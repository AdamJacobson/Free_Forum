class AddIndexToModeratorJoins < ActiveRecord::Migration
  def change
    add_index :moderator_joins, :board_id
    add_index :moderator_joins, :user_id
  end
end
