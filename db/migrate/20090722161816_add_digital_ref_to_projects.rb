class AddDigitalRefToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :digital_ref_id, :integer
  end

  def self.down
    remove_column :projects, :digital_ref_id
  end
end
