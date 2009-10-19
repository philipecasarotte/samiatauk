ActionController::Routing::Routes.draw do |map|

  map.namespace :admin do |admin|
    admin.login "login", :controller => "user_sessions", :action => "new"
    admin.logout "logout", :controller => "user_sessions", :action => "destroy"
    admin.resource :user_session
    admin.resources :pages, :as => :paginas, :collection => { :reorder => :get, :order => :post }
    admin.resources :users
    admin.resources :downloads, :collection => { :reorder => :get, :order => :post }
    admin.resources :posts, :as => :blog do |post|
      post.resources :comments, :as => :comentarios
    end
    admin.resources :photo_galleries, :as => :galerias, :collection => { :reorder => :get, :order => :post } do |photo_gallery|
      photo_gallery.resources :images, :as => :fotos, :collection => { :reorder => :get, :order => :post }
    end
    admin.root :controller => "pages"
  end
  
  map.sitemap "/sitemap.xml", :controller => "pages", :action => "sitemap", :format => "xml"
  map.pages "/paginas/:action", :controller => "pages"
  map.resources :pages, :as => :paginas
  map.science_downloads "/downloads/ciencia", :controller => "downloads", :action => "science"
  map.faith_downloads "/downloads/evangelismo", :controller => "downloads", :action => "faith"
  map.resources :downloads
  map.resources :photo_galleries, :as => :fotos
  map.resources :posts, :as => :blog do |post|
    post.resources :comments, :as => :comentarios
  end
  map.by_date "/blog/arquivo/:year/:month", :controller => "posts", :action => "by_date"
  map.resources :photo_galleries, :as => :galerias do |photo_gallery|
    photo_gallery.resources :images, :as => :fotos
  end
  map.resources :comments, :as => :comentarios

  map.not_found "/404", :controller => "pages", :action => "404"
  map.application_error "/500", :controller => "pages", :action => "500"
  map.unprocessable_entity "/422", :controller => "pages", :action => "422"
  map.root :controller => "pages", :action => "index"
end

