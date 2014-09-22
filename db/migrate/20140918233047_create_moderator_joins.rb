class CreateModeratorJoins < ActiveRecord::Migration
	def change
		create_table :moderator_joins do |t|
			t.integer :user_id
			t.integer :board_id

			t.timestamps
		end
	end
end
