module UsersHelper
  def widget_for user
    return unless user
    render :partial => 'users/widget', :locals => {:user => user }
  end

  def collection_widget_for users, object = nil, number_of_groups = 3
    return 'Not assigned' if users.empty?
    render :partial => 'users/list', :locals => {:users => users, :object => object, :groups => number_of_groups }
  end
end
