Given /^I have no comments$/ do
  Comment.destroy_all
end

Then /^I should have ([0-9+]) comments?$/ do |count|
  assert_equal Comment.count, count.to_i
end
