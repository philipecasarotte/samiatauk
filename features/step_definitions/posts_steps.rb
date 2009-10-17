Given /^I have no posts$/ do
  Post.destroy_all
end

Then /^I should have ([0-9+]) posts?$/ do |count|
  assert_equal Post.count, count.to_i
end
