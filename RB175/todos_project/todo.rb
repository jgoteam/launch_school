require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require "tilt/erubis"

configure do
  enable :sessions
  set :erb, :escape_html => true
  set :session_secret, "921d6c5462e46de6ead3453150d9ed835e698242b1cc5b9ca07a0f68f1b95cfb"
end

helpers do
  def todos_remaining(todos)
    todos.count { |_, todo| todo[:completed] == false}
  end

  def todos_left_as_fraction(todos)
    "#{todos_remaining(todos)} / #{todos.size}"
  end

  def all_completed?(todos)
    (todos.size > 0) && todos_remaining(todos).zero?
  end

  def todo_status(todo)
    todo[:completed] ? "complete" : ""
  end

  def list_status(todos)
    all_completed?(todos) ? "complete" : ""
  end

  def sort_lists(lists, &block)
    complete_lists, incomplete_lists =
      lists.partition { |_, list| all_completed?(list[:todos]) }

    (incomplete_lists + complete_lists).each { |id, list| yield(id, list) }
  end

  def sort_todos(todos, &block)
    complete_todos, incomplete_todos =
      todos.partition { |_, todo| todo[:completed] }

    (incomplete_todos + complete_todos).each { |id, todo| yield(id, todo) }
  end
end

before do
  session[:lists] ||= {}
end

not_found do
  redirect "/"
end

# Dynamically generate id for item
def generate_id(items)
  max = items.map(&:first).max || 0
  max + 1
end

# Input validation for out of range list IDs
def valid_list_id?(id)
  unless session[:lists].keys.include?(id.to_i)
    session[:error] = "The specified list was not found."
    redirect "/"
  end
end

# Return error message if error exists. Return nil if there is no error.
def name_error(str, reference)
  if !(1..100).cover?(str.size)
    "The name needs to be 1 and 100 characters long."
  elsif reference.values.any? { |item| item[:name] == str }
    "That name already exists."
  end
end

get "/" do
  redirect "/lists"
end

# View all the lists
get "/lists" do
  @lists = session[:lists]
  erb :lists
end

# Render the new list form
get "/lists/new" do
  erb :new_list
end

# Render the edit list name form
get "/lists/:id/edit" do
  valid_list_id?(params[:id])
  @list = session[:lists][params[:id].to_i]
  erb :edit_list
end

# Create a new list
post "/lists" do
  list_name = params[:list_name].strip
  error = name_error(list_name, session[:lists])

  if error
    session[:error] = error
    erb :new_list
  else
    session[:lists][generate_id(session[:lists])] = { name: list_name, todos: {} }
    session[:success] = "The list has been created."
    redirect "/"
  end
end

# Edit a list name
post "/lists/:id/edit" do
  valid_list_id?(params[:id])

  old_name = session[:lists][params[:id].to_i][:name]
  new_name = params[:list_name].strip
  error = name_error(new_name, session[:lists])

  if error
    session[:error] = error
    @invalid_name = new_name
    erb :edit_list
  else
    session[:lists][params[:id].to_i][:name] = new_name
    session[:success] = "Your list '#{old_name}' is now named '#{new_name}'."
    redirect "/lists/#{params[:id]}"
  end
end

# Delete a list
post "/lists/:id/delete" do
  valid_list_id?(params[:id])
  deleted_list_name = session[:lists].delete(params[:id].to_i)[:name]

  if env["HTTP_X_REQUESTED_WITH"] == "XMLHttpRequest"
    "/lists"
  else
    session[:success] = "Your list '#{deleted_list_name}' has been successfully deleted."
    redirect "/lists"
  end
end

# View list todos
get "/lists/:id" do
  valid_list_id?(params[:id])

  @list = session[:lists][params[:id].to_i]
  erb :list
end

# Add list todo
post "/lists/:id/todos" do
  list = session[:lists][params[:id].to_i]
  list_todos, list_name = list[:todos], list[:name]
  error = name_error(params[:todo].strip, list_todos)

  new_todo = { name: params[:todo].strip, completed: false }

  if error
    session[:error] = error.gsub("list", "todo")
  else
    list_todos[generate_id(list_todos)] = new_todo
    session[:success] =
      "Your todo '#{new_todo[:name]}' has been added to your '#{list_name}' list."
  end

  redirect "/lists/#{params[:id]}"
end

# Toggle list todo
post "/lists/:id/todos/:index" do
  todos = session[:lists][params[:id].to_i][:todos]
  todo = todos.fetch(params[:index].to_i)
  todo[:completed] = params[:completed] == "true"

  session[:success] = "Your task '#{todo[:name]}' has been successfully updated."
  redirect "/lists/#{params[:id]}"
end

# Complete all list todos
post "/lists/:id/complete_all" do
  list = session[:lists][params[:id].to_i]
  all_complete = list[:todos].none? { |_, todo| todo[:completed] == false }

  if all_complete
    session[:error] = "There are no todos to mark as complete!"
  else
    list[:todos].each { |_, todo| todo[:completed] = true }
    session[:success] = "Your tasks for your '#{list[:name]}' list have all been marked as completed."
  end

  redirect "/lists/#{params[:id]}"
end

# Delete list todo
post "/lists/:id/todos/:index/delete" do
  todos = session[:lists][params[:id].to_i][:todos]
  deleted_todo_name = todos.delete(params[:index].to_i)[:name]

  if env["HTTP_X_REQUESTED_WITH"] == "XMLHttpRequest"
    status 204
  else
    session[:success] = "Your todo '#{ deleted_todo_name }' has been successfully deleted."
    redirect "/lists/#{params[:id]}"
  end
end
