class AddRankIdToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :rank_id, :integer
  end
end
