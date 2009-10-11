class Admin::ImagesController< Admin::AdminController
  belongs_to :photo_gallery
  
  create.wants.html {redirect_to(collection_url)}
  update.wants.html {redirect_to(collection_url)}
 
  include Order
end
