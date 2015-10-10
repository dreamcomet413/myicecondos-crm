# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Fat Free CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
require File.expand_path("../acceptance_helper.rb", __FILE__)

feature 'Campaigns', %q{
  In order to increase customer satisfaction
  As a user
  I want to manage campaigns
} do

  before :each do
    do_login_if_not_already(:first_name => 'Bill', :last_name => 'Murray')
  end

  scenario 'should view a list of campaigns' do
    3.times { |i| FactoryGirl.create(:campaign, :name => "Campaign #{i}") }
    visit campaigns_page
    page.should have_content('Campaign 0')
    page.should have_content('Campaign 1')
    page.should have_content('Campaign 2')
    page.should have_content('Create Campaign')
  end

  scenario 'should create a campaign', :js => true do
    visit campaigns_page
    click_link 'Create Campaign'
    page.should have_selector('#campaign_name', :visible => true)
    fill_in 'campaign_name', :with => 'Cool Campaign'
    select 'On Hold', :from => 'campaign_status'
    click_link 'Comment'
    fill_in 'comment_body', :with => 'This campaign is very important'
    click_button 'Create Campaign'

    page.should have_content('Cool Campaign')
    page.should have_content('On Hold')

    find('div#campaigns').click_link 'Cool Campaign'
    page.should have_content('This campaign is very important')

    click_link "Dashboard"
    page.should have_content("Bill Murray created campaign Cool Campaign")
    page.should have_content("Bill Murray created comment on Cool Campaign")
  end

  scenario "remembers the comment field when the creation was unsuccessful", :js => true do
    visit campaigns_page
    click_link 'Create Campaign'

    click_link 'Comment'
    fill_in 'comment_body', :with => 'This campaign is very important'
    click_button 'Create Campaign'

    find('#comment_body').should have_content('This campaign is very important')
  end

  scenario 'should view and edit a campaign', :js => true do
    FactoryGirl.create(:campaign, :name => "My Cool Campaign")
    visit campaigns_page
    click_link 'My Cool Campaign'
    click_link 'Edit'
    fill_in 'campaign_name', :with => 'My Even Cooler Campaign'
    select 'Started', :from => 'campaign_status'
    click_button 'Save Campaign'
    page.should have_content('My Even Cooler Campaign')
  page.should have_content('My Even Cooler Campaign')
    click_link 'Dashboard'
    page.should have_content("Bill Murray updated campaign My Even Cooler Campaign")
  end

  scenario 'should delete a campaign', :js => true do
    FactoryGirl.create(:campaign, :name => "Old Campaign")
    visit campaigns_page
    click_link 'Old Campaign'
    click_link 'Delete?'
    page.should have_content('Are you sure you want to delete this campaign?')
    click_link 'Yes'
    page.should have_content('Old Campaign has been deleted.')
    find('div#campaigns').should_not have_content('Old Campaign')
  end

  scenario 'should search for a campaign', :js => true do
    2.times { |i| FactoryGirl.create(:campaign, :name => "Campaign #{i}") }
    visit campaigns_page
    find('#campaigns').should have_content("Campaign 0")
    find('#campaigns').should have_content("Campaign 1")
    fill_in 'query', :with => "Campaign 0"
    find('#campaigns').should have_content("Campaign 0")
    find('#campaigns').should_not have_content("Campaign 1")
    fill_in 'query', :with => "Campaign"
    find('#campaigns').should have_content("Campaign 0")
    find('#campaigns').should have_content("Campaign 1")
    fill_in 'query', :with => "False"
    find('#campaigns').should_not have_content("Campaign 0")
    find('#campaigns').should_not have_content("Campaign 1")
  end
end
