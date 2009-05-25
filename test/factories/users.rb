Factory.sequence :login do |n|
  "user#{n}"
end

Factory.sequence :email do |n|
  "user#{n}@example.com"
end

Factory.define :user do |u|
  u.login Factory.next(:login)
  u.email Factory.next(:email)
  u.name 'User'
  u.password 'secret'
  u.password_confirmation 'secret'
  u.remember_token_expires_at "#{1.days.from_now.to_s}"
  u.remember_token '77de68daecd823babbb58edb1c8e14d7106e83bb'
end

Factory.define :quentin, :parent => :user do |u|
  u.login Factory.next(:login)
  u.email Factory.next(:email)
  u.name 'Quentin'
  u.password 'monkey'
  u.password_confirmation 'monkey'
end

Factory.define :admin, :parent => :user do |u|
  u.login Factory.next(:login)
  u.email Factory.next(:email)
  u.name 'Admin'
  u.password 'monkey'
  u.password_confirmation 'monkey'
  u.roles { [ Factory.create(:admin_role) ] }
end