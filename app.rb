#!/usr/bin/env ruby
require('sinatra')
require('sinatra/reloader')
require('./lib/volunteer')
require('./lib/project')
require('pry')
require("pg")
require('dotenv/load')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker", :password => ENV['PG_PASS']})

get('/') do
  redirect to('/volunteers')
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
  erb(:volunteer)
end

delete('/volunteers/:id') do
  volunteer = Volunteer.find(params[:id].to_i)
  volunteer.delete
  redirect to('/volunteers')
end

