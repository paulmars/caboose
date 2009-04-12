ActionController::Routing::Routes.draw do |map|
  map.resource :password_reset
  map.resource :session
  map.resources :users do |user|
    user.resources :user_assets, :as => :assets
  end
  
  map.connect ':controller/service.wsdl', :action => 'wsdl'
  map.connect '', :controller => 'users'

  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
