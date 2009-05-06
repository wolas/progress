class AddStuffToTasks < ActiveRecord::Migration
  def self.up
    add_column :tasks, :start_date, :datetime
  end

  def self.down
    remove_column :tasks, :start_date
  end
end
