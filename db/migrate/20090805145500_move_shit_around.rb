class MoveShitAround < ActiveRecord::Migration
  def self.up
    remove_column :projects, :account
    remove_column :projects, :state
    remove_column :projects, :priority
    
    add_column :tasks, :state, :string
    add_column :tasks, :priority, :string
  end

  def self.down
    add_column :projects, :account, :string
    add_column :projects, :state, :string
    add_column :projects, :priority, :string
    
    remove_column :tasks, :state
    remove_column :tasks, :priority
  end
end
