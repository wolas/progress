module UsersHelper
  def widget_for user, size = nil
    return unless user
    render :partial => 'users/widget', :locals => {:user => user, :size => size }
  end

  def collection_widget_for users, options = {}
    return 'Not assigned' if users.empty?
    render :partial => 'users/list', :locals => {:hide_users => options[:hide], :users => users, :object => options[:object], :groups => options[:groups_of] }
  end
end
