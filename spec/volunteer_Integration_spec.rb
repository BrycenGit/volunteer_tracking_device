require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)



  describe 'the project creation path', {:type => :feature} do
    it 'takes the user to the homepage where they can create a project' do
      visit('/')
      fill_in('title', :with => 'Teaching Kids to Code')
      click_button('Create Project')
      expect(page).to have_content('Teaching Kids to Code')
    end
  end

  describe 'the project update path', {:type => :feature} do
    it 'allows a user to change the name of the project' do
      test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
      test_project.save
      id = test_project.id
      visit '/'
      click_link("#{id}")
      fill_in('title', :with => 'Teaching Ruby to Kids')
      click_button('Update')
      expect(page).to have_content('Teaching Ruby to Kids')
    end
  end

  describe 'the project delete path', {:type => :feature} do
    it 'allows a user to delete a project' do
      test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
      test_project.save
      id = test_project.id
      visit "/projects/#{id}"
      click_button('Delete project')
      visit '/'
      expect(page).not_to have_content("Teaching Kids to Code")
    end
  end

  describe 'the volunteer detail page path', {:type => :feature} do
    it 'shows a volunteer detail page' do
      test_project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
      test_project.save
      project_id = test_project.id.to_i
      test_volunteer = Volunteer.new({:name => 'Jasmine', :project_id => project_id, :id => nil})
      test_volunteer.save
      volunteer_id = test_volunteer.id.to_i
      visit "/projects/#{project_id}"
      click_link("#{volunteer_id}")
      click_button('Remove Volunteer From Project')
      expect(page).not_to have_content("#{project_id}")
    end
  end