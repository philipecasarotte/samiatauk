Given /^I have no images$/ do
  Image.destroy_all
end

Then /^I should have ([0-9+]) images?$/ do |count|
  assert_equal Image.count, count.to_i
end
