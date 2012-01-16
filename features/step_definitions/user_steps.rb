Given /^there are the following users:$/ do |table|
  table.hashes.each do |attributes|
    unconfirmed = attributes.delete("unconfirmed") == "true"
    @user = User.create!(attributes)
    @user.update_attribute("admin", attributes["admin"] == "true")
    @user.confirm! unless unconfirmed
  end
end

Given /^I am signed in as "([^\"]*)"$/ do |email|
  @user = User.find_by_email!(email)
  visit path_to("the homepage")
  click_link("Sign in")
  fill_in("Email", :with => @user.email)
  fill_in("Password", :with => 'password')
  click_button("Sign in")
  steps(%Q{
    Then I should see "Signed in successfully."
  })
end