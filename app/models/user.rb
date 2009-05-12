class User < ActiveRecord::Base
  acts_as_authentic

  has_and_belongs_to_many :projects, :order => 'end_date ASC'
  has_and_belongs_to_many :tasks, :order => 'end_date ASC'
  has_and_belongs_to_many :events, :order => 'date DESC'

  validates_uniqueness_of :login, :email

  def name
    login
  end
end
