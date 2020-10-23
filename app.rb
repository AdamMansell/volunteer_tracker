require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
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

get('/projects/:id/edit') do
  @project = Project.find(params[:id].to_i)
  erb(:edit_project)
end

patch('/projects/:id') do
  @project = Project.find(params[:id].to_i)
  @project.update(title: params[:title])
  erb(:show_project)
end

delete('/projects/:id') do
  @project = Project.find(params[:id].to_i)
  @project.delete
  redirect to('/projects')
end

post('/projects/:id/volunteers') do
  @project = Project.find(params[:id].to_i)
  volunteer = Volunteer.new(name: params[:name], project_id: @project.id, id: nil)
  volunteer.save
  erb(:show_project)
end

get('/projects/:id/volunteers/:volunteer_id') do
  @project = Project.find(params[:id].to_i)
  @volunteer = Volunteer.find(params[:volunteer_id].to_i)
  erb(:show_volunteer)
end

patch('/projects/:id/volunteers/:volunteer_id') do
  @project = Project.find(params[:id].to_i)
  @volunteer = Volunteer.find(params[:volunteer_id].to_i)
  if params[:name]
    @volunteer.update(name: params[:name]) 
  end
  erb(:show_volunteer)
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
