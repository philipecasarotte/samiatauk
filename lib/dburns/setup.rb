#######################################################################################################
# Substantial portions of this code were adapted from the Radiant CMS project (http://radiantcms.org) #
#######################################################################################################
module Dburns
  class Setup
  
    class << self
      def bootstrap(config)
        setup = new
        setup.bootstrap(config)
        setup
      end
    end
    
    attr_accessor :config
    
    def bootstrap(config)    
      # make sure the uploads directory exists
      FileUtils.mkdir_p "#{RAILS_ROOT}/public/uploads/"
      
      @config = config
      @admin = create_admin_user(config[:admin_password], config[:admin_login], config[:admin_name], config[:admin_email])
      load_sample_data
      announce "Finished.\n\n"
    end

    def create_admin_user(password, login, name, email)
      
      announce "Creating admin user..."
      attributes = {
        :password => password,
        :password_confirmation => password,
        :email => email,
        :name => name,
        :login => login
      }
      
      admin = User.create(attributes)
      
      announce "Created user #{login}"
      
      # create an admin role and and assign the admin user to that role
      role = Role.create(:name => 'admin')
      admin.roles << role
      admin.save
      
      announce "Created #{role.name} user #{admin.login}"
      
      admin      
    end
    
    
    def load_sample_data
      announce "Creating Default Pages..."
      
      get_pages    
      @pages.each do |page|
        create = Page.create(:title => page[:title], :body => page[:body], :is_protected => true)
        puts "Created #{page[:title]} Page."
      end

    end
         
    private
      
      def get_pages
        @pages = [
                    {:title => "Page Not Found", :body => "The page you requested was not found"}, 
                    {:title => "Contact", :body => "Send a message to our staff"}
                  ]
      end
    
      def announce(string)
        puts "\n#{string}"
      end
  end
end