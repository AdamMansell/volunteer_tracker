require('sinatra')
require('sinatra/reloader')
# require('./lib/')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect(dbname: "volunteer_tracker")

get('/') do
  redirect to('/projects')
end

get('/projects') do
  @projects = Project.all
  erb(:projects)
end

post('/projects') do
  title = params[:title]
  Project.new(title: title, id: nil).save
  redirect to('/projects')
end

get('/projects/:id') do
  @project = Project.find(params[:id].to_i)
  erb(:show_project)
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
