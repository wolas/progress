class Event < ActiveRecord::Base
  belongs_to :project
  has_and_belongs_to_many :users
  has_many :comments, :as => :owner, :order => 'created_at DESC', :dependent => :destroy

  validates_presence_of :time, :date, :name, :project
  validate_on_create :date_in_future

  named_scope :in_future, :conditions => ['date > ?', Date.today]
  named_scope :for_date, lambda { |*args| {:conditions => {:date => args.first.to_date }} }


  def time
    return unless date
    date.strftime '%H:%M'
  end

  def late?
    return unless date
    date < Date.today
  end

  def description?
    description && !description.empty?
  end

  def date_in_future
    return unless date
    errors.add(:date, "must be in the future") if late?
    errors.add(:date, "cannot be past the project end date") if date > project.end_date.to_date
  end

  def happens_in day
    date.to_date == day.to_date
  end

  def to_xml
    "<event textColor='#000' color='##{project.colour}' caption='#{project.name}' title='#{time} - #{name}' link='/projects/#{project.id}/events/#{id}' start='#{date.strftime("%a, %d %b %Y %T %Z")}'>#{description}</event>"
  end
end
