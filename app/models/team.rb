class Team < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :user
  
  validates_presence_of :name
end
