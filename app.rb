require 'sinatra/activerecord'
require 'pg'
require 'sinatra'
require 'sinatra/reloader'
require './lib/task'
require './lib/list'
also_reload 'lib/**/*.rb'

get '/' do
  @tasks = Task.all
  erb :index
end

get 'tasks/:id/edit' do
  @task = Task.find(params[:id].to_i)
  erb :task_edit
end

patch 'tasks/:id' do
  description = params[:description]
  @task = Task.find(params[:id].to_i)
  @task.update({description: description})
  @tasks = Task.all
  erb :index
end


post '/create_task' do
  @tasks = Task.all
  description = params[:user_task]
  Task.create(description: description, done: false)
  erb :index
end

get("/method") do
  @tasks = Task.all
  @tasks.each { |task| task.destroy}
  @lists = List.all
  @lists.each { |list| list.destroy}
  redirect "/"
end
