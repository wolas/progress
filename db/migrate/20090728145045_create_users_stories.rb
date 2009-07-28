class CreateUsersStories < ActiveRecord::Migration
  def self.up
    create_table :stories_users, :id => false do |t|
      t.integer :user_id
      t.integer :story_id
    end
  end

  def self.down
    drop_table :stories_users
  end
end
