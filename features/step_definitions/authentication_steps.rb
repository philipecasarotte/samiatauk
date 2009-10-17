Given /^I am logged in as (.+)$/ do |u|
  user = Factory(u)
  When %{I go to the login page}
  And %{I fill in "Login" with "#{user.login}"}
  And %{I fill in "Senha" with "#{user.password}"}
  And %{I press "Login"}
end

Given /^no user exists with a login of "([^\"]*)"$/ do |login|
  assert_nil User.find_by_login(login)
end

Given /^I signed up with "(.*)\/(.*)"$/ do |login, password|
  user = Factory :user, 
    :login                 => login, 
    :password              => password,
    :password_confirmation => password
end 

Given /^I am signed up with "(.*)\/(.*)" as "(.*)"$/ do |login, password, role|
  user = Factory :user, 
    :login                 => login, 
    :password              => password,
    :password_confirmation => password
  role = Factory(:role, :name => role)
  user.roles << role
end 

When /^I sign in as "(.*)\/(.*)"$/ do |login, password|
  When %{I fill in "Login" with "#{login}"}
  And %{I fill in "Senha" with "#{password}"}
  And %{I press "Login"}
end

When /^I sign out$/ do
  visit '/admin/logout'
end
