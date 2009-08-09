ActionController::Routing::Routes.draw do |map|
  map.resource :password_reset
  map.resource :session
  map.resources :users do |user|
    user.resources :user_assets, :as => :assets
  end
  
  map.connect ':controller/service.wsdl', :action => 'wsdl'
  map.connect '', :controller => 'users'

  map.signup  '/signup', :controller => 'users', :action => 'new'
  map.login   '/login', :controller => 'sessions', :action => 'new'
  map.logout  '/logout', :controller => 'sessions', :action => 'destroy'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
