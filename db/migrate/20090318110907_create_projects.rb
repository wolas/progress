class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.datetime :end_date
      t.integer :client_id
      t.text :description

    end
  end

  def self.down
    drop_table :projects
  end
end
