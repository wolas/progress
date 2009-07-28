class Story < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :parent, :polymorphic => true
  belongs_to :creator, :class_name => 'User'

  before_create :propagate

  validates_presence_of :creator

  def propagate
    self.users = parent.people_involved.compact.uniq - [creator]
  end

end
