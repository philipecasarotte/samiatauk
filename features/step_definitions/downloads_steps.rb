Given /^I have no downloads$/ do
  Download.destroy_all
end

Then /^I should have ([0-9+]) downloads?$/ do |count|
  assert_equal Download.count, count.to_i
end
