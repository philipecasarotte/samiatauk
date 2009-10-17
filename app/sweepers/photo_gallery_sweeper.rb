class PhotoGallerySweeper < ApplicationSweeper
  observe :photo_gallery, :image
  has_permalink

  def after_clear_cache(model)
    expire_page('/index')
    if model.class.name == "Image"
      index_path = photo_galleries_path
      path = photo_gallery_path(model.photo_gallery)
      expire_page(path) if path
      expire_page(index_path) if index_path
    else
      sweep_directory(index_model_path(model), "/", "system", "images", "javascripts")
    end
  end

end
