class User < ActiveRecord::Base
  TASKS = [:tasks_as_digital_refs, :tasks_as_art_directors, :tasks_as_art_operatives, :tasks_as_flash_operatives, :tasks_as_front_end_developers, :tasks_as_back_end_developers]

  acts_as_authentic
  
  has_and_belongs_to_many :teams
  has_and_belongs_to_many :tasks_as_art_directors, :join_table => :tasks_art_director, :class_name => 'Task'
  has_and_belongs_to_many :tasks_as_art_operatives, :join_table => :tasks_art_operative, :class_name => 'Task'
  has_and_belongs_to_many :tasks_as_flash_operatives, :join_table => :tasks_flash_operative, :class_name => 'Task'
  has_and_belongs_to_many :tasks_as_front_end_developers, :join_table => :tasks_front_end_developer, :class_name => 'Task'
  has_and_belongs_to_many :tasks_as_back_end_developers, :join_table => :tasks_back_end_developer, :class_name => 'Task'
  has_and_belongs_to_many :tasks_as_digital_refs, :join_table => :tasks_digital_ref, :class_name => 'Task'

  has_and_belongs_to_many :projects, :order => 'end_date ASC'
  has_and_belongs_to_many :events, :order => 'date DESC'
  has_and_belongs_to_many :roles

  has_many :users_stories
  has_many :stories, :through => :users_stories, :order => 'created_at DESC'
  has_many :created_stories, :class_name => 'Story', :order => 'created_at DESC', :foreign_key => :creator_id

  belongs_to :team
  belongs_to :company

  validates_uniqueness_of :login, :email

  has_attached_file :face, :styles => { :small=> "30x30>", :medium => "50x50>", :thumb => "100x100>" }, :default_url => 'face.png'
  
  def tasks
    TASKS.map {|tasks_as| self.send tasks_as.to_s }.flatten.uniq
  end

  def projects_involved options = {}
    prjs = (tasks.map { |task| task.project } + events.map { |event| event.project }).uniq
    options[:open] ? prjs.select {|p| p.open? } : prjs
  end

  def has_role? role
    roles.count(:conditions => {:name => role.to_s}) > 0
  end

  def add_role role
    return if has_role?(role)
    r = Role.find_by_name(role.to_s)
    roles << (r ? r : Role.create(:name => role.to_s))
  end

  def tasks_with_state state = 'open'
    case state.to_s
      when 'open'   then tasks.select {|task| task.open? }
      when 'closed' then tasks.select {|task| not task.open? }
      when 'completed' then tasks.select(&:completed)
      else tasks
    end
  end
  
  def full_name
    "#{name} #{surname}"
  end
end
