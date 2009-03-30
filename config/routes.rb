ActionController::Routing::Routes.draw do |map|
  # resources
  map.resources :clients, :has_many => [:projects]
  map.resources :projects, :has_many => [:tasks], :member => {:close => :get, :reopen => :get}
  map.resources :tasks, :member => {:mark_completed => :get, :mark_open => :get}
  map.resources :users, :has_many => [:tasks, :projects]

  map.resource :user_session
  map.resource :account, :controller => "users"

  # named routes
  map.welcome 'welcome', :controller => 'welcome'
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.register 'register', :controller => 'users', :action => 'new'
  map.root :controller => "welcome"

  # defaults
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
