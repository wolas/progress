class Task < ActiveRecord::Base

  belongs_to :project
  has_and_belongs_to_many :users
  has_many :comments, :as => :owner, :order => 'created_at DESC', :dependent => :destroy

  validates_presence_of :end_date, :start_date, :name, :project
  validate_on_create :dates_in_future

  named_scope :open, :conditions => {:completed => false}
  named_scope :completed, :conditions => {:completed => true}
  named_scope :closed, :conditions => {:completed => true}

  def late?
    return unless end_date
    end_date < Date.today
  end

  def dates_in_future
    return unless end_date and start_date
    errors.add(:end_date, "must be in the future") if end_date < Date.today
    errors.add(:start_date, "must be in the future") if start_date < Date.today
    errors.add(:start_date, "cannot be after the end date") if start_date > end_date
    errors.add(:end_date, "cannot be past the project end date") if project and end_date > project.end_date
  end

  def days_remaining
    (end_date.to_date - Date.today).to_i + 1
  end

  def style
    result = 'color: red;' if late?
    result = 'text-decoration: line-through;' if completed?
    result = '' if project.closed?
    result or ''
  end

  def happens_in day
    (start_date.to_date..end_date.to_date).to_a.include? day.to_date
  end

  def to_xml
    "<event textColor='#000' color='##{project.colour}' caption='#{project.name}' title='#{name}' link='/tasks/#{id}' start='#{start_date.to_s(:timeline)}' end='#{end_date.to_s(:timeline)}' isDuration='true'>#{description}</event>"
  end

end
