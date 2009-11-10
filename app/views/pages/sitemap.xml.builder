xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  xml.url do
    xml.loc         url_for(root_url)
    xml.lastmod     w3c_date(Time.now)
    xml.changefreq  "always"
    xml.priority    1.0
  end

  # posts
  @posts.each do |post|
    xml.url do
      xml.loc         url_for(post_url(post))
      xml.lastmod     w3c_date(post.updated_at)
      xml.changefreq  "weekly"
      xml.priority    0.8
    end
  end

  # downloads
  @downloads.each do |download|
    xml.url do
      xml.loc         url_for(download_url(download.permalink))
      xml.lastmod     w3c_date(download.updated_at)
      xml.changefreq  "monthly"
      xml.priority    0.6
    end 
  end

  # photo galleries
  @photo_galleries.each do |photo_gallery|
    xml.url do
      xml.loc         url_for(photo_gallery_url(photo_gallery.permalink))
      xml.lastmod     w3c_date(photo_gallery.updated_at)
      xml.changefreq  "monthly"
      xml.priority    0.6
    end 
  end

  # pages
  @pages.each do |page|
    xml.url do
      xml.loc         url_for(page_url(page.permalink))
      xml.lastmod     w3c_date(page.updated_at)
      xml.changefreq  "yearly"
      xml.priority    0.4
    end 
  end
end