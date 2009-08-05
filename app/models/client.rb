class Client < ActiveRecord::Base

  belongs_to :company
  has_many :projects, :order => 'end_date ASC'

  validates_presence_of :name
end
