class User < ActiveRecord::Base
  
  # acts_as_authentic already validates presence and format of: login, email, password; also password confirmation
  
  acts_as_authentic do |c|
      c.validates_format_of_login_field_options = { :with => /^[a-z0-9]+$/ }
      c.validates_format_of_email_field_options = { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  end

  has_and_belongs_to_many :roles

  validates_presence_of :name

  named_scope :admins, :include => :roles, :conditions => "roles.name = 'admin'"
  
  # has_role? simply needs to return true or false whether a user has a role or not.  
  # It may be a good idea to have "admin" roles return true always
  def has_role?(role_in_question)
    @_list ||= self.roles.collect(&:name)
    return true if @_list.include?("admin")
    (@_list.include?(role_in_question.to_s) )
  end

end
