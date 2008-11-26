ActionController::Routing::Routes.draw do |map|

  map.namespace :admin do |admin|
    admin.logout '/logout', :controller => 'sessions', :action => 'destroy'
    admin.login '/login', :controller => 'sessions', :action => 'new'
    admin.resources :pages
    admin.resources :users
    admin.resource :session
    admin.root :controller => 'pages'
  end

  map.resources :pages
  map.root :controller => 'pages', :action => 'index'
end
