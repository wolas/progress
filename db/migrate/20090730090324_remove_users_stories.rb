class RemoveUsersStories < ActiveRecord::Migration
  def self.up
    drop_table :stories_users
  end

  def self.down
    create_table :stories_users, :id => false do |t|
      t.integer :user_id
      t.integer :story_id
    end
  end
end
