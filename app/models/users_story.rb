class UsersStory < ActiveRecord::Base
  belongs_to :user
  belongs_to :story

  def mark_seen
    update_attribute :seen, true
  end
end
