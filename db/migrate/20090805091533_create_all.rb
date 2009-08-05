class CreateAll < ActiveRecord::Migration
  def self.up

    create_table "clients", :force => true do |t|
      t.string  "name"
      t.text    "description"
      t.integer "brand_id"
    end

    create_table "comments", :force => true do |t|
      t.integer  "owner_id"
      t.string   "owner_type"
      t.text     "body"
      t.integer  "user_id"
      t.datetime "created_at"
    end

    create_table "events", :force => true do |t|
      t.string   "name"
      t.datetime "date"
      t.integer  "project_id"
      t.text     "description"
    end

    create_table "events_users", :id => false, :force => true do |t|
      t.integer "event_id"
      t.integer "user_id"
    end

    create_table "projects", :force => true do |t|
      t.string   "name"
      t.datetime "end_date"
      t.integer  "client_id"
      t.text     "description"
      t.boolean  "closed",      :default => false
      t.string   "colour"
      t.string   "state"
      t.string   "priority"
      t.string   "account"
      t.integer  "manager_id"
    end

    create_table "projects_users", :id => false, :force => true do |t|
      t.integer "project_id"
      t.integer "user_id"
    end

    create_table "roles", :force => true do |t|
      t.string "name"
    end

    add_index "roles", ["name"], :name => "index_roles_on_name"

    create_table "roles_users", :id => false, :force => true do |t|
      t.integer "user_id"
      t.integer "role_id"
    end

    create_table "stories", :force => true do |t|
      t.integer  "parent_id"
      t.string   "parent_type"
      t.text     "body"
      t.integer  "creator_id"
      t.datetime "created_at"
    end

    create_table "tasks", :force => true do |t|
      t.string   "name"
      t.datetime "end_date"
      t.integer  "project_id"
      t.boolean  "completed",   :default => false, :null => false
      t.text     "description"
      t.datetime "start_date"
    end

    create_table "tasks_art_director", :id => false, :force => true do |t|
      t.integer "task_id"
      t.integer "user_id"
    end

    create_table "tasks_art_operative", :id => false, :force => true do |t|
      t.integer "task_id"
      t.integer "user_id"
    end

    create_table "tasks_back_end_developer", :id => false, :force => true do |t|
      t.integer "task_id"
      t.integer "user_id"
    end

    create_table "tasks_digital_ref", :id => false, :force => true do |t|
      t.integer "task_id"
      t.integer "user_id"
    end

    create_table "tasks_flash_operative", :id => false, :force => true do |t|
      t.integer "task_id"
      t.integer "user_id"
    end

    create_table "tasks_front_end_developer", :id => false, :force => true do |t|
      t.integer "task_id"
      t.integer "user_id"
    end

    create_table "tasks_users", :id => false, :force => true do |t|
      t.integer "task_id"
      t.integer "user_id"
    end

    create_table "teams", :force => true do |t|
      t.string "name"
    end

    create_table "users_stories", :force => true do |t|
      t.integer "user_id"
      t.integer "story_id"
      t.boolean "seen",     :default => false
    end
  end

  def self.down
    drop_table :clients
    drop_table :comments
    drop_table :events
    drop_table :events_users
    drop_table :projects
    drop_table :projects_users
    drop_table :roles
    drop_table :roles_users
    drop_table :stories
    drop_table :tasks
    drop_table :tasks_art_director
    drop_table :tasks_art_operative
    drop_table :tasks_back_end_developer
    drop_table :tasks_digital_ref
    drop_table :tasks_flash_operative
    drop_table :tasks_front_end_developer
    drop_table :tasks_users
    drop_table :teams
    drop_table :users_stories
  end
end
