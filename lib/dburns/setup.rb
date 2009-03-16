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
      puts "Finished.\n\n"
    end

    def create_admin_user(password, login, name, email)
      
      puts "Creating admin user..."
      attributes = {
        :password => password,
        :password_confirmation => password,
        :email => email,
        :name => name,
        :login => login
      }
      
      admin = User.create(attributes)
      
      puts "Created user #{login}"
      
      # create an admin role and and assign the admin user to that role
      role = Role.create(:name => 'admin')
      admin.roles << role
      admin.save
      
      puts "Created #{role.name} user #{admin.login}"
      
      admin      
    end
    
  end
end