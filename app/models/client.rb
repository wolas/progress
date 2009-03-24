class Client < ActiveRecord::Base

  has_many :projects, :order => 'end_date ASC'

  validates_presence_of :name


end
