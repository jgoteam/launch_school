require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  @dir_name = Dir.new("public").path
  @file_list = Dir.children("public").sort
  erb :home
end

get "/reverse" do
  @dir_name = Dir.new("public").path
  @file_list = Dir.children("public").sort.reverse
  erb :home
end