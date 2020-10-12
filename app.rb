
require('sinatra')
require 'sinatra/base'
require('sinatra/reloader')
require('./lib/volunteer')
require('./lib/project')
require("pg")
require('dotenv/load')

also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker", :password => ENV['PG_PASS']})

get('/') do
  redirect to('/projects')
end

get('/volunteers') do
  @volunteers = Volunteer.all
  erb(:volunteers)
end

get('/projects') do
  @projects = Project.all
  erb(:projects)
end

post('/volunteers') do
  name = params[:name]
  volunteer = Volunteer.new({:name => name, :id => nil, :project_id => nil})
  volunteer.save
  redirect to('/volunteers')
end

post('/projects') do
  title = params[:title]
  project = Project.new({:title => title, :id => nil})
  project.save
  redirect to('/projects')
end

get('/volunteers/:id') do
  @volunteer = Volunteer.find(params[:id].to_i)
  @projects = @volunteer.projects
  erb(:volunteer)
end

delete('/volunteers/:id') do
  volunteer = Volunteer.find(params[:id].to_i)
  volunteer.delete
  redirect to('/volunteers')
end

post('/volunteers/:id') do
  if params[:empty]
    empty = params[:empty]
    volunteer = Volunteer.find(params[:id].to_i)
    volunteer.update({:empty => empty})
    redirect to("/volunteers/#{volunteer.id}")
  end
end

get('/projects/:id') do
  @project = Project.find(params[:id].to_i)
  @volunteers = @project.volunteers
  erb(:project)
end

delete('/projects/:id') do
  project = Project.find(params[:id].to_i)
  project.delete
  redirect to('/projects')
end

post('/projects/:id') do
  if params[:name]
    project = Project.find(params[:id].to_i)
    project.add_volunteer({:name => params[:name]})
    redirect to("/projects/#{project.id}")
  else
    project = Project.find(params[:id].to_i)
    project.update({:title => params[:title]})
    redirect to("/projects/#{project.id}")
  end
end

