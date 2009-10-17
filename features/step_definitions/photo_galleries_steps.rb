Given /^I have no photo galleries$/ do
  PhotoGallery.destroy_all
end

Then /^I should have ([0-9+]) photo galleries?$/ do |count|
  assert_equal PhotoGallery.count, count.to_i
end

Then /^I should have ([0-9+]) photo gallery?$/ do |count|
  assert_equal PhotoGallery.count, count.to_i
end
