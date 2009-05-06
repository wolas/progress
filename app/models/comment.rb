class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :owner, :polymorphic => true

  validates_presence_of :body, :owner
  validates_length_of :body, :minimum => 1
end
