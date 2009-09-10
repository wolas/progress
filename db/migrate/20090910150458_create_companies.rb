class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table "companies", :force => false do |t|
      t.string "name"
      t.string "city"
      t.string "street"
      t.string "number"
      t.string "postcode"
      t.string "phone"
      t.string "fax"
      t.string "iva"
    end
  end

  def self.down
      drop_table :companies
  end
end
