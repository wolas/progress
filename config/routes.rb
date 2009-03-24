ActionController::Routing::Routes.draw do |map|
  map.resources :clients, :has_many => [:projects]
  map.resources :projects, :has_many => [:tasks]
  map.resources :tasks, :member => {:mark_completed => :get, :mark_open => :get}

  # Authlogic routes
  map.resource :user_session
  map.root :controller => "user_sessions", :action => "new"
  map.resource :account, :controller => "users"
  map.resources :users


  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
