class PostSweeper < ApplicationSweeper
  observe :post, :comment
  has_permalink

  def after_clear_cache(model)
    if model.class.name == "Comment"
      index_path = posts_path
      path = post_path(model.post)
      expire_page(path) if path
      expire_page(index_path) if index_path
    else
      expire_page('/index')
      sweep_directory(index_model_path(model), "/", "system", "images", "javascripts")
    end
  end

end
