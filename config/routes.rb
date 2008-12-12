ActionController::Routing::Routes.draw do |map|

  map.namespace :admin do |admin|
    admin.logout '/logout', :controller => 'sessions', :action => 'destroy'
    admin.login '/login', :controller => 'sessions', :action => 'new'
    admin.resources :pages, :collection=>{ :reorder=>:get, :order=>:post }
    admin.resources :users
    admin.resource :session
    admin.root :controller => 'pages'
  end

  map.pages '/pages/:action', :controller => 'pages'
  map.resources :pages
  map.root :controller => 'pages', :action => 'index'
end
