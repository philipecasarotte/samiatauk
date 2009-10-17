Given /^I have no pages$/ do
  Page.destroy_all
end

Then /^I should have ([0-9+]) pages?$/ do |count|
  assert_equal Page.count, count.to_i
end

Then /^I should see a contact form$/ do
  assert_have_selector 'form', {:action => page_path('contato')}
end
