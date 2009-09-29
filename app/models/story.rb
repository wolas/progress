class Story < ActiveRecord::Base
  has_many :users_stories
  has_many :users, :through => :users_stories

  belongs_to :parent, :polymorphic => true
  belongs_to :creator, :class_name => 'User'

  after_create :propagate
  before_create :assign_comment

  validates_presence_of :creator_id
  
  def assign_comment
    self.comment = true if comment_body
  end

  def propagate
    self.users = parent.people_involved.uniq - [creator]
  end
  
  def body
    return "<div class='quote'>#{comment_body}</div>" if comment?
    
    cd, f, t = [changed_data, from, to].map {|att| div_wrap att }
    
    return "was marked as #{cd}" if to.eql?("1")
    return "was marked as not #{cd}" if to.eql?("0")
    return "added #{t} as #{cd}" if from.empty?
    return "removed #{cd}" if to.empty?
    return "changed #{cd} from #{f} to #{t}"
  end
  
  def div_wrap content
    "<div class='changed_data'>#{content.to_s.humanize}</div>"
  end
end
