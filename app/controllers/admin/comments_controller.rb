class Admin::CommentsController < Admin::AdminController
  belongs_to :post
  
  create.wants.html {redirect_to(collection_url)}
  update.wants.html {redirect_to(collection_url)}
end
