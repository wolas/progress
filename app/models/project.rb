class Project < ActiveRecord::Base

  belongs_to :client
  has_many :tasks, :order => 'end_date ASC', :dependent => :destroy
  has_and_belongs_to_many :users

  validates_presence_of :end_date, :name
  validate_on_create :date_in_future

  def late?
    end_date < Date.today
  end

  def date_in_future
    errors.add(:end_date, "must be in the future") if end_date && late?
  end

  def description?
    description && !description.empty?
  end

  def days_remaining
    (end_date.to_date - Date.today).to_i
  end

  def tasks_remaining
    tasks.all(:conditions => {:completed => false})
  end

  def percentage_complete
    task = tasks.count
    remaining = tasks_remaining.count
    completed = task - remaining

    return 100 if remaining == 0
    ((completed.to_f / remaining.to_f) * 100.00).to_i
  end

  def style
    result = 'color: red;' if late?
    result = 'text-decoration: line-through;' if closed?
    result or ''
  end
end
