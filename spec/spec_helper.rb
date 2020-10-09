require 'rspec'
require 'pg'
require 'volunteer'
require 'project'
require 'pry'
require('dotenv/load')

DB = PG.connect({:dbname => "", :password => ENV['PG_PASS'] })

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM volunteers *;")
    DB.exec("DELETE FROM projects *;")
    DB.exec("DELETE FROM volunteers_projects *;")
  end
end