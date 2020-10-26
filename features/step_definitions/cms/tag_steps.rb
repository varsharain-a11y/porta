# frozen_string_literal: true

Given "{provider} has tags" do |provider|
  FactoryBot.create :tag, account: provider
end

Given "{provider} has the tag {string}" do |provider, tag|
  FactoryBot.create :tag, account: provider, name: tag
end

When "I create a bcms tag" do
  visit cms_tags_path
  find(:xpath, './/a[@id="add_button"]').click

  fill_in 'Name', with: 'Name'

  submit_tag
end

When "I update a tag" do
  visit cms_tags_path
  find(:xpath, tag_xpath(current_account.tags.first.id)).click
  find(:xpath, './/a[@id="edit_button"]').click

  fill_in 'Name', with: 'new tag'
  submit_tag

  sleep 0.5
end

When "I delete a tag" do
  visit cms_tags_path
  find(:xpath, tag_xpath(current_account.tags.first.id)).click
  find(:xpath, ".//a[@id='delete_button']").click

  sleep 0.5
end

Then "I should see my tags" do
  current_account.tags.each do |tag|
    assert has_xpath? tag_xpath(tag.id)
  end
end

Then "I should see my tag" do
  tag = current_account.tags.first
  # see the class='"dividers"' !
  assert has_xpath?("#{tag_xpath(tag.id)}//td[@class='name']/div[@class='\"dividers\"']", /#{tag.name}/)
end

Then "I should see the tag changed" do
  assert_equal 'new tag', current_account.tags.first.name
end

Then "I should see no tags" do
  step %(I should see the tag was deleted)
end

Then "I should see the tag was deleted" do
  Tag.all.each do |tag|
    assert has_no_xpath?(".//tr[@id='tag_#{tag.id}']")
  end
end

def submit_tag
  find(:xpath, './/input[@id="tag_submit"]').click
end

def tag_xpath(id)
  ".//tr[@id='tag_#{id}']"
end
