class AddBrandIdToClients < ActiveRecord::Migration
  def self.up
    add_column :clients, :brand_id, :integer
  end

  def self.down
    remove_column :clients, :brand_id
  end
end
