class CreateUsersStoriesAgain < ActiveRecord::Migration
  def self.up
    create_table :users_stories do |t|
      t.integer :user_id
      t.integer :story_id
      t.boolean :seen, :default => false
    end
  end

  def self.down
    drop_table :users_stories
  end
end
