class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :topic_id
      t.string :content

      t.timestamps
    end
  end
end
