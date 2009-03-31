class Task < ActiveRecord::Base

  belongs_to :project
  has_and_belongs_to_many :users
  has_many :comments, :as => :owner

  validates_presence_of :end_date, :name, :project
  validate_on_create :date_in_future

  def late?
    return unless end_date
    end_date < Date.today
  end

  def description?
    description && !description.empty?
  end

  def date_in_future
    return unless end_date
    errors.add(:end_date, "must be in the future") if late?
    errors.add(:end_date, "cannot be past the project end date") if end_date > project.end_date
  end

  def days_remaining
    (end_date.to_date - Date.today).to_i
  end

  def style
    result = 'color: red;' if late?
    result = 'text-decoration: line-through;' if completed?
    result = '' if project.closed?
    result or ''
  end

end
