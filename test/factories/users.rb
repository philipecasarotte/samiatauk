Factory.sequence :login do |n|
  "user#{n}"
end

Factory.sequence :email do |n|
  "user#{n}@example.com"
end

Factory.sequence :persistence_token do
  Authlogic::Random.hex_token.to_s
end

Factory.define :user do |u|
  u.login Factory.next(:login)
  u.email Factory.next(:email)
  u.name 'User'
  u.password 'secret'
  u.password_confirmation 'secret'
  u.password_salt salt = Authlogic::Random.hex_token
  u.crypted_password Authlogic::CryptoProviders::Sha512.encrypt("secret" + salt)
  u.perishable_token Authlogic::Random.friendly_token
  u.persistence_token Factory.next(:persistence_token)
end

Factory.define :quentin, :parent => :user do |u|
  u.login Factory.next(:login)
  u.email Factory.next(:email)
  u.name 'Quentin'
  u.password 'monkey'
  u.password_confirmation 'monkey'
  u.password_salt salt = Authlogic::Random.hex_token
  u.crypted_password Authlogic::CryptoProviders::Sha512.encrypt("monkey" + salt)
end

Factory.define :admin, :parent => :user do |u|
  u.login Factory.next(:login)
  u.email Factory.next(:email)
  u.name 'Admin'
  u.password 'monkey'
  u.password_confirmation 'monkey'
  u.password_salt salt = Authlogic::Random.hex_token
  u.crypted_password Authlogic::CryptoProviders::Sha512.encrypt("monkey" + salt)
  u.roles { [ Factory.create(:admin_role) ] }
  u.persistence_token Authlogic::Random.hex_token.to_s
end