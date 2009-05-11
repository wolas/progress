class SortDatesInEvents < ActiveRecord::Migration
  def self.up
    change_column :events, :date, :datetime
    remove_column :events, :time
  end

  def self.down
    add_column :events, :time, :time
    change_column :events, :date, :date
  end
end
