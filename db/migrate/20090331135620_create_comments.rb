class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :owner_id
      t.string :owner_type
      t.text :body
      t.boolean :automatic
      t.integer :user_id

      t.datetime :created_at
    end
  end

  def self.down
    drop_table :comments
  end
end
