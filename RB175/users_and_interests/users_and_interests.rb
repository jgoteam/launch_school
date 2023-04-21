require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'
require 'yaml'

helpers do
  def joiner(arr)
    arr.join(', ').reverse.sub(',', ' dna ,').reverse
  end
end

before do
  @user_data = YAML.load_file("users.yaml")
  @number_of_users =
    YAML.load_file("users.yaml").size
  @number_of_interests =
    YAML.load_file("users.yaml").map { |name, data| data[:interests].size }.sum
end

not_found do
  redirect "/"
end

get "/" do
  erb :home
end

get "/:name" do
  @others_data =
    YAML.load_file("users.yaml").delete_if { |name, _| name == params[:name].to_sym }
  erb :name
end

