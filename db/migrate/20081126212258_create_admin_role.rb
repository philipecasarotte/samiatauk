class CreateAdminRole < ActiveRecord::Migration
  def self.up
    u = User.create(:login => "admin", :password => "bundinha", :password_confirmation => "bundinha", :email => "dev.dburns@gmail.com")
    r = Role.create(:name => "admin")
    u.roles << r
  end

  def self.down
    Role.find_by_name("admin").destroy
    User.find_by_login("admin").destroy
  end
end
