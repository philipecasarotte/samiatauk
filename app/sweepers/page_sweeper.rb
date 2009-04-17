class PageSweeper < ActionController::Caching::Sweeper
  observe Page

  def after_save(page)
    clear_page_cache(page)
  end

  def after_destroy(page)
    clear_page_cache(page)
  end

  def clear_page_cache(page)
    ["/pages/#{page.permalink}", '/index'].each{|action| expire_page(action) }
  end

end
