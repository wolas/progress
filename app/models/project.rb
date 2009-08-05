class Project < ActiveRecord::Base
  PEOPLE = [:manager, :account]
  STATES = [:waiting_for_brief, :waiting_for_feedback, :waiting_for_materials, :in_progress, :on_support, :periodical, :standby, :testing]
  PRIORITIES = [:low, :medium, :high, :urgent]

  belongs_to :client

  has_many :tasks, :order => 'end_date ASC', :dependent => :destroy
  has_many :events, :order => 'date DESC', :dependent => :destroy
  has_many :stories, :as => :parent, :order => 'created_at DESC', :dependent => :destroy

  belongs_to :manager, :class_name => 'User'
  belongs_to :account, :class_name => 'User'

  validates_presence_of :end_date, :name, :colour
  validate_on_create :date_in_future

  named_scope :open, :conditions => {:closed => false}

  def people
    PEOPLE.map{|person| eval person.to_s }.compact
  end

  def open?
    not closed?
  end

  def full_name
    str = ""
    str += "(#{client.name}) " if client
    str += "#{name}"
  end

  def people_involved conditions = {}
    (tasks.all(conditions).map { |task| task.users } + events.all(conditions).map { |event| event.users }).flatten.uniq
  end

  def late?
    end_date < Date.today
  end

  def date_in_future
    errors.add(:end_date, "must be in the future") if end_date && late?
  end

  def days_remaining
    (end_date.to_date - Date.today).to_i + 1
  end

  def percentage_complete
    task = tasks.count
    completed = tasks.completed.count
    remaining = task - completed

    return 100 if remaining == 0
    ((completed.to_f / task.to_f) * 100.00).to_i
  end

  def tasks_with_state state = 'open'
    case state
      when 'open'   then tasks.open
      when 'closed' then tasks.closed
      else tasks
    end
  end

  def style
    result = 'color: red;' if late?
    result = 'text-decoration: line-through;' if closed?
    result or ''
  end
end
