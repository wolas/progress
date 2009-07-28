class RemovePeopleFromProjects < ActiveRecord::Migration

  def self.up
    remove_column :projects, :back_end_developer_id
    remove_column :projects, :front_end_developer_id
    remove_column :projects, :flash_operative_id
    remove_column :projects, :art_operative_id
    remove_column :projects, :art_director_id
    remove_column :projects, :digital_ref_id
  end

  def self.down
    add_column :projects, :art_director_id, :integer
    add_column :projects, :art_operative_id, :integer
    add_column :projects, :flash_operative_id, :integer
    add_column :projects, :front_end_developer_id, :integer
    add_column :projects, :back_end_developer_id, :integer
    add_column :projects, :digital_ref_id, :integer
  end
end
