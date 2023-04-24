require "sinatra"
require "sinatra/reloader" if development?
require "sinatra/content_for"
require "tilt/erubis"

configure do
  enable :sessions
  set :session_secret, 'secret'
end

helpers do
  def todos_remaining(todos)
    todos.count { |todo| todo[:completed] == false}
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
    complete_lists, incomplete_lists = lists.partition { |list| all_completed?(list[:todos]) }

    incomplete_lists.each { |list| yield(list, lists.index(list)) }
    complete_lists.each { |list| yield(list, lists.index(list)) }
  end

  def sort_todos(todos, &block)
    complete_todos, incomplete_todos = todos.partition { |todo| todo[:completed] }

    incomplete_todos.each { |todo| yield(todo, todos.index(todo)) }
    complete_todos.each { |todo| yield(todo, todos.index(todo)) }
  end
end

before do
  session[:lists] ||= []
end

not_found do
  redirect "/"
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
  @list = session[:lists][params[:id].to_i]
  erb :edit_list
end

# Return error message if error exists. Return nil if there is no error.
def list_name_error(str)
  if !(1..100).cover?(str.size)
    "The list name needs to be 1 and 100 characters long."
  elsif session[:lists].any? { |session| session[:name] == str }
    "That list name already exists."
  end
end

# Create a new list
post "/lists" do
  list_name = params[:list_name].strip
  error = list_name_error(list_name)

  if error
    session[:error] = error
    erb :new_list
  else
    session[:lists] << {name: list_name, todos: [] }
    session[:success] = "The list has been created."
    redirect "/"
  end
end

# Edit list name
post "/lists/:id/edit" do
  old_name = session[:lists][params[:id].to_i][:name]
  new_name = params[:list_name].strip
  error = list_name_error(new_name)

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
  list_name = session[:lists].delete_at(params[:id].to_i)[:name]
  session[:success] = "Your list '#{list_name}' has been successfully deleted."
  redirect "/lists"
end

# View list todos
get "/lists/:id" do
  redirect "/" unless params[:id].to_i < session[:lists].size
  @list = session[:lists][params[:id].to_i]
  erb :list
end

# Add list todo
post "/lists/:id/todos" do
  new_todo = { name: params[:todo].strip, completed: false }
  error = list_name_error(new_todo[:name])

  if error
    session[:error] = error.gsub("list", "todo")
  else
    list_todos = session[:lists][params[:id].to_i][:todos]
    list_name = session[:lists][params[:id].to_i][:name]

    list_todos << new_todo
    session[:success] =
      "Your todo '#{new_todo[:name]}' has been added to your '#{list_name}' list."
  end

  redirect "/lists/#{params[:id]}"
end

# Toggle List Todo
post "/lists/:id/todos/:index" do
  todo = session[:lists][params[:id].to_i][:todos][params[:index].to_i]
  todo[:completed] = params[:completed] == "true"

  session[:success] = "Your task '#{todo[:name]}' has been successfully updated."
  redirect "/lists/#{params[:id]}"
end

# Complete all List Todos
post "/lists/:id/complete_all" do
  list = session[:lists][params[:id].to_i]
  all_complete = list[:todos].none? { |todo| todo[:completed] == false }

  if all_complete
    session[:error] = "There are no todos to mark as complete!"
  else
    list[:todos].each { |todo| todo[:completed] = true }
    session[:success] = "Your tasks for your '#{list[:name]}' have all been marked as completed."
  end

  redirect "/lists/#{params[:id]}"
end

# Delete List todo
post "/lists/:id/todos/:index/delete" do
  todo_name = session[:lists][params[:id].to_i][:todos].delete_at(params[:index].to_i)[:name]
  session[:success] = "Your todo '#{todo_name}' has been successfully deleted."
  redirect "/lists/#{params[:id]}"
end
