class AddColourToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :colour, :string
  end

  def self.down
    remove_column :projects, :colour
  end
end
