class Project < ActiveRecord::Base
  PEOPLE = [:manager, :account]

  belongs_to :client

  has_many :tasks, :order => 'end_date DESC', :dependent => :destroy
  has_many :events, :order => 'date DESC', :dependent => :destroy
  has_many :stories, :as => :parent, :order => 'created_at DESC', :dependent => :destroy

  belongs_to :manager, :class_name => 'User'
  belongs_to :account, :class_name => 'User'

  validates_presence_of :name
  validate_on_create :date_in_future

  named_scope :open, :conditions => {:closed => false}

  before_create :random_colour
  before_update :report_updates
  
  def report_updates
    changes.each { |att, values| stories.create :from => values.first, :to => values.last, :changed_data => att, :creator => UserSession.find.user }
  end
  
  def all_stories
    stories + tasks.map(&:stories).flatten.compact
  end
  
  def random_colour
    self.colour = "323232" if colour.nil? or colour.empty?
  end

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
  
  def end_date
    ed = read_attribute(:end_date)
    return if tasks.empty? and ed.nil?
    ed ? ed : tasks.last.end_date
  end

  def late?
    return unless end_date
    end_date < Date.today
  end

  def date_in_future
    errors.add(:end_date, "must be in the future") if end_date && late?
  end

  def days_remaining
    return unless end_date
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
  
  def to_s
    str = (client ? "#{client.name} - #{name}" : name) + "\n"
    str_length = str.length
    str << (" " * str_length) + "No tasks" if tasks.empty?
    
    tasks.each do |task| 
      users = task.users.map(&:name).join(", ")
      str << (" " * str_length) + task.name
      str << (users.empty? ? "\n" : ": (#{users})\n")
    end
    
    str << "\n\n"
  end
end
