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


