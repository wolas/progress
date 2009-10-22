class Client < ActiveRecord::Base

  belongs_to :company
  has_many :projects, :order => 'end_date ASC'
  
  validates_presence_of :name
  
  def stories
    projects.map(&:all_stories).flatten.sort_by(&:created_at).reverse
  end
  
  def events
    projects.map(&:events).flatten
  end
  
  def tasks
    projects.map(&:tasks).flatten
  end
  
  def tasks_with_state state = 'open'
    case state
      when 'open'   then tasks.select {|t| t.open?}
      when 'closed' then tasks.select {|t| not t.open?}
      else tasks
    end
  end
end
