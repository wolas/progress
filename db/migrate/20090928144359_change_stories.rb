class ChangeStories < ActiveRecord::Migration
  def self.up
    add_column :stories, :changed_data, :string
    add_column :stories, :from, :string
    add_column :stories, :to, :string
    add_column :stories, :comment, :boolean
    add_column :stories, :comment_body, :string
    remove_column :stories, :body
  end

  def self.down
    remove_column :stories, :changed_data
    remove_column :stories, :from
    remove_column :stories, :to
    remove_column :stories, :comment
    remove_column :stories, :comment_body
    add_column :stories, :body, :string
  end
end
