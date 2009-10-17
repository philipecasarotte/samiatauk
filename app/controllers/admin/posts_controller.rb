class Admin::PostsController < Admin::AdminController
  
  cache_sweeper :post_sweeper
  create.wants.html {redirect_to(collection_url)}
  update.wants.html {redirect_to(collection_url)}
end
