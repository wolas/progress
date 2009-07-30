class User < ActiveRecord::Base
  acts_as_authentic

  has_and_belongs_to_many :projects, :order => 'end_date ASC'
  has_and_belongs_to_many :tasks, :order => 'end_date ASC'
  has_and_belongs_to_many :events, :order => 'date DESC'
  has_and_belongs_to_many :roles

  has_many :users_stories
  has_many :stories, :through => :users_stories, :order => 'created_at DESC'
  has_many :created_stories, :class_name => 'Story', :order => 'created_at DESC', :foreign_key => :creator_id

  belongs_to :team

  validates_uniqueness_of :login, :email

  has_attached_file :avatar, :styles => { :small=> "30x30>", :medium => "50x50>", :thumb => "100x100>" }, :default_url => 'default_face.png'

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
    case state
      when 'open'   then tasks.open
      when 'closed' then tasks.closed
      else tasks
    end
  end

  def name
    login
  end
end
