class AddLockedToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :locked, :boolean, :default => false
  end
end
