class PageSweeper < ApplicationSweeper
  observe :page
  has_permalink

  def after_clear_cache(model)
    expire_page('/index')
    sweep_directory(index_model_path(model), "/", "system", "images", "javascripts")
    sweep_directory("blog")
    sweep_directory("fotos")
    sweep_directory("downloads")
  end

end
