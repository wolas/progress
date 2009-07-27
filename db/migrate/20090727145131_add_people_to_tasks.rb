class AddPeopleToTasks < ActiveRecord::Migration
  def self.up

    create_table :tasks_art_director, :id => false do |t|
      t.integer :task_id
      t.integer :user_id
    end

    create_table :tasks_art_operative, :id => false do |t|
      t.integer :task_id
      t.integer :user_id
    end

    create_table :tasks_flash_operative, :id => false do |t|
      t.integer :task_id
      t.integer :user_id
    end

    create_table :tasks_front_end_developer, :id => false do |t|
      t.integer :task_id
      t.integer :user_id
    end

    create_table :tasks_back_end_developer, :id => false do |t|
      t.integer :task_id
      t.integer :user_id
    end

    create_table :tasks_digital_ref, :id => false do |t|
      t.integer :task_id
      t.integer :user_id
    end
  end

  def self.down
    drop_table :tasks_art_director
    drop_table :tasks_art_operative
    drop_table :tasks_flash_operative
    drop_table :tasks_front_end_developer
    drop_table :tasks_back_end_developer
    drop_table :tasks_digital_ref
  end
end
