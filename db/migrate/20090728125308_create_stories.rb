class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.integer :parent_id
      t.string :parent_type
      t.text :body
      t.integer :user_id
      t.timestamps

    end
  end

  def self.down
    drop_table :stories
  end
end
