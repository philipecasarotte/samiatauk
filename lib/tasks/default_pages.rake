desc "Create the default pages in CMS that can't be deleted."
task :default_pages => [:environment, :clear_default_pages] do
 puts "Creating Default Pages..."
 get_pages    
 @pages.each do |page|
   create = Page.create(:title => page, :body => "Coming soon.", :is_protected => true)
   puts "Created #{page} Page."
 end
 puts "Generating Slugs for the New Pages..."
 exec "rake friendly_id:make_slugs MODEL=Page"
end

task :clear_default_pages => :environment do
  puts "Destroying default pages before create it again."
  get_pages
  @pages.each do |page|
   destroy = Page.find(:first, :conditions => {:title => page}) 
   Page.destroy(destroy.id) unless destroy.blank?
   puts "Deleted #{page} Page." unless destroy.blank?
  end
end

def get_pages
  @pages = ["Page Not Found", "Contact"]
end