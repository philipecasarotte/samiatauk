class PageSweeper < ApplicationSweeper
  observe :page

  def after_clear_cache(model)
    expire_page('/index')
    sweep_directory(index_model_path(model), "/", "system", "images", "javascripts")
  end

end

