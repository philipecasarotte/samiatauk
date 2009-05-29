class ApplicationSweeper < ActionController::Caching::Sweeper
  include ActionController::UrlWriter

  def before_save(model)
    model = model.class.send :find, model.id rescue nil
    clear_cache(model)
  end

  def before_destroy(model)
    model = model.class.send :find, model.id
    clear_cache(model)
  end

  private

  def after_clear_cache(model)
  end

  def clear_cache(model)
    index_path = index_model_path(model)
    path = model_path(model)
    expire_page(path) if path
    expire_page(index_path) if index_path
    after_clear_cache(model)
  end

  def model_path(model)
    send "#{model.class.name.underscore}_path", model rescue nil
  end

  def index_model_path(model)
    send "#{model.class.name.underscore.pluralize}_path" rescue nil
  end

  def old_model(model)
    @old_model = model.class.send :find, model.id
  end
end

