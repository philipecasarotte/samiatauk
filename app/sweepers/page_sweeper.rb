class PageSweeper < ActionController::Caching::Sweeper
  observe Page

  def after_save(page)
    ["/pages/#{page.permalink}", '/index'].each{|action| expire_page(action) }
  end
end
