require 'yaml'

user_data = YAML.load_file("users.yaml")

# user_data.each do |name, data|
#   puts "#{name}"
#   puts "\temail: #{data[:email]}"
#   print "\tinterests: "
#   data[:interests].each { |interest| print "#{interest} " }
#   puts
# end

p user_data.map { |name, data| data[:interests].join(', ') }

# <% @user_data.each do |name, data| %>
#   <a href="/<%= name %>"> <%= name %> </a>
#   <li><%= "\temail: #{data[:email]}" %></li>
#   <li><%= "\tinterests: " %>
#   <% data[:interests].each do |interest| %>
#     <%= interest %>
#   <% end %></li>
#   <p></p>
# <% end %>