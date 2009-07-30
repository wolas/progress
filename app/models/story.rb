class Story < ActiveRecord::Base
  has_many :users_stories
  has_many :users, :through => :users_stories

  belongs_to :parent, :polymorphic => true
  belongs_to :creator, :class_name => 'User'

  after_create :propagate

  validates_presence_of :creator

  def propagate
    self.users = parent.people_involved.uniq - [creator]
  end
end
