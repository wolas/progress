class AddPeopleToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :art_director_id, :integer
    add_column :projects, :art_operative_id, :integer
    add_column :projects, :flash_operative_id, :integer
    add_column :projects, :front_end_developer_id, :integer
    add_column :projects, :back_end_developer_id, :integer
  end

  def self.down
    remove_column :projects, :back_end_developer_id
    remove_column :projects, :front_end_developer_id
    remove_column :projects, :flash_operative_id
    remove_column :projects, :art_operative_id
    remove_column :projects, :art_director_id
  end
end
