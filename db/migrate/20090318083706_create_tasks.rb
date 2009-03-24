class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :name
      t.datetime :end_date
      t.integer :project_id
      t.boolean :completed, :default => false, :null => false
      t.text :description

    end
  end

  def self.down
    drop_table :tasks
  end
end
