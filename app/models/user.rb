class User < ActiveRecord::Base
  acts_as_authentic

  has_and_belongs_to_many :projects, :order => 'end_date ASC'
  has_and_belongs_to_many :tasks, :order => 'end_date ASC'
  has_and_belongs_to_many :events, :order => 'date DESC'
  has_and_belongs_to_many :roles


  belongs_to :team

  validates_uniqueness_of :login, :email

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
