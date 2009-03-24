class Task < ActiveRecord::Base

  belongs_to :project
  has_and_belongs_to_many :users

  validates_presence_of :end_date, :name, :project
  validate :date_in_future, :before => :save

  def date_in_future
    errors.add(:end_date, "must be in the future")if end_date && end_date < Date.today
    errors.add(:end_date, "cannot be past the project end date")if end_date && end_date > project.end_date
  end

  def days_remaining
    (end_date.to_date - Date.today).to_i
  end
end
