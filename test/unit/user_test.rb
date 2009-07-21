require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase

  context "A User" do
    should_eventually "have named scope :admins"
    should_be_authentic
    should_have_and_belong_to_many :roles
    should_have_db_index :login
    should_validate_presence_of :name
  end

end
