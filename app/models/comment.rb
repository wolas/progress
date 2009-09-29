class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :owner, :polymorphic => true

  validates_presence_of :body, :owner
  validates_length_of :body, :minimum => 1
  
  before_create :create_story
  
  def create_story
    owner.stories.create! :comment_body => body, :creator => UserSession.find.user
  end
  
end
