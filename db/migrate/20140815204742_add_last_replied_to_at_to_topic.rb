class AddLastRepliedToAtToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :last_replied_to_at, :timestamp
  end
end
