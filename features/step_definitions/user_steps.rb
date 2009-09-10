Given /^I have no users except for admin$/ do
  User.all.each {|u| u.destroy unless u.has_role?('admin')}
end

Given /^the user "([^\"]*)" has no role$/ do |user|
end

Given /^the user "([^\"]*)" has a role "([^\"]*)"$/ do |user, role|
  u = User.find_by_login(user)
  r = Role.find_by_name(role)
  u.roles << r
end

When /^I check the role "([^\"]*)"$/ do |role|
  r = Role.find_by_name(role)
  When %{I check "user_role_ids_#{r.id}"}
end

Then /^I should have ([0-9]+) users?$/ do |count|
  assert_equal User.count, count.to_i
end
