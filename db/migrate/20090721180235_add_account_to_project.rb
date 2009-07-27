class AddAccountToProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :account, :string
  end

  def self.down
    remove_column :projects, :account
  end
end
