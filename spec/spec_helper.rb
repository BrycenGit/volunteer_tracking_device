require('dotenv/load')

require 'rspec'
require 'pg'
require 'volunteer'
require 'project'

require 'pry'



DB = PG.connect({:dbname => "volunteer_tracker_test", :password => ENV['PG_PASS'] })

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM volunteers *;")
    DB.exec("DELETE FROM projects *;")

  end
end