require('sinatra')
require('sinatra/reloader')
# require('./lib/')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker_development"})

get('/') do
  redirect to('/projects')
end

get('/projects') do
  @projects = Project.all
  erb(:projects)
end

# Project (1)
# name
# has_many :volunteers

# Volunteer
# belongs_to :project

# volunteers table:
# name
# email
# address
# project_id (foreign key) 

# vol 1: name: name 1 project_id: 1
# vol 2: name: name 2 project_id: 1
