class WhatTheFutTheFuckHappensWithStories < ActiveRecord::Migration
  def self.up
    rename_column :stories, :user_id, :creator_id
  end

  def self.down
    rename_column :stories, :creator_id, :user_id
  end
end
