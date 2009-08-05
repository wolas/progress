class RemoveBrands < ActiveRecord::Migration
  def self.up
    drop_table :brands
  end

  def self.down
    create_table "brands", :force => true do |t|
      t.string "name"
    end
  end
end
