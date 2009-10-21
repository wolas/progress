class Task < ActiveRecord::Base
  include ERB::Util
  
  PEOPLE = [:digital_refs, :art_directors, :art_operatives, :flash_operatives, :front_end_developers, :back_end_developers]
  STATES = %w( waiting_for_brief waiting_for_feedback waiting_for_materials in_progress on_support periodical standby testing )
  PRIORITIES = %w( low medium high urgent)
  
  belongs_to :project

  has_and_belongs_to_many :art_directors, :join_table => :tasks_art_director, :class_name => 'User'
  has_and_belongs_to_many :art_operatives, :join_table => :tasks_art_operative, :class_name => 'User'
  has_and_belongs_to_many :flash_operatives, :join_table => :tasks_flash_operative, :class_name => 'User'
  has_and_belongs_to_many :front_end_developers, :join_table => :tasks_front_end_developer, :class_name => 'User'
  has_and_belongs_to_many :back_end_developers, :join_table => :tasks_back_end_developer, :class_name => 'User'
  has_and_belongs_to_many :digital_refs, :join_table => :tasks_digital_ref, :class_name => 'User'


  has_many :comments, :as => :owner, :order => 'created_at DESC', :dependent => :destroy
  has_many :stories, :as => :parent, :order => 'created_at DESC', :dependent => :destroy

  validates_presence_of :end_date, :start_date, :name, :project
  validate_on_create :dates_in_future

  named_scope :open, :conditions => {:completed => false}
  named_scope :completed, :conditions => {:completed => true}
  named_scope :closed, :conditions => {:completed => true}

  before_update :report_updates
  
  def start_date
    read_attribute(:start_date) or Date.today
  end
  
  def report_updates
    changes.each { |att, values| stories.create :from => values.first, :to => values.last, :changed_data => att, :creator => UserSession.find.user }
  end

  def users
    PEOPLE.map{|user| eval user.to_s }.flatten.uniq
  end
  alias people_involved users
  
  def urgent?
    priority.eql? 'urgent'
  end

  def late?
    return unless end_date
    end_date < Date.today
  end

  def open?
    not completed?
  end

  def dates_in_future
    return unless end_date and start_date
    errors.add(:end_date, "must be in the future") if end_date < Date.today
    errors.add(:start_date, "cannot be after the end date") if start_date > end_date
    errors.add(:end_date, "cannot be past the project end date") if project and project.end_date and end_date > project.end_date
  end

  def days_remaining
    (end_date.to_date - Date.today).to_i + 1
  end
  
  def priority_colour
    case priority
      when 'low' then '50b848'
      when 'medium' then 'f6ba18'
      when 'high' then 'f67618'
      when 'urgent' then 'f61818'
    end
  end

  def style
    result = 'text-decoration: blink;' if late?
    result = 'text-decoration: line-through;' if completed?
    result = '' if project.closed?
    result or ''
  end

  def happens_in day
    (start_date.to_date..end_date.to_date).to_a.include? day.to_date
  end

  def to_xml
    "<event textColor=\"#000\" color=\"##{project.colour}\" caption=\"#{h(project.name)}\" title=\"#{h(name)}\" link=\"/tasks/#{id}\" start=\"#{start_date.to_s(:timeline)}\" end=\"#{end_date.to_s(:timeline)}\" isDuration=\"true\">#{h(description)}</event>"
  end

end
