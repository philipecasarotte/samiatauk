Factory.define :role do |r|
  r.name 'user'
end

Factory.define :admin_role, :parent => :role do |r|
  r.name 'admin'
end 