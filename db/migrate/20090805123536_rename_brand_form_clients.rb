class RenameBrandFormClients < ActiveRecord::Migration
  def self.up
    rename_column :clients, :brand_id, :company_id
  end

  def self.down
    rename_column :clients, :company_id, :brand_id
  end
end
