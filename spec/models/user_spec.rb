require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do

  should_have_named_scope :admins
  should_be_authentic
  should_have_and_belong_to_many :roles
  should_have_db_index :login
  should_validate_presence_of :name

end
