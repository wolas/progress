class CreateUsersIfNotPresent < ActiveRecord::Migration
  def self.up  
    create_table "users", :force => false do |t|
      t.string   "surname"
      t.string   "phone"
      t.string   "mobile"
      t.string   "login"
      t.string   "fax"
      t.string   "email"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "company_id"
      t.boolean  "admin",               :default => false
      t.string   "skype"
      t.string   "name"
      t.string   "access_code"
      t.string   "avatar_file_name"
      t.string   "avatar_content_type"
      t.integer  "avatar_file_size"
      t.string   "crypted_password",    :default => "",    :null => false
      t.string   "password_salt",       :default => "",    :null => false
      t.string   "persistence_token",   :default => "",    :null => false
      t.string   "website"
      t.text     "more_information"
    end
  end
  
  def self.down

  end
end