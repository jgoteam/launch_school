require 'socket'

def parse_request(line)
  method, path, scheme = line.split

  queries = path.gsub(/[?\/]/, '').split('&')
  params = queries.each_with_object({}) do |pair, hash|
            key, value = pair.split('=')
            hash[key] = value.to_i
           end
  [method, path, params, scheme]
end

server = TCPServer.new('localhost', 3003)

loop do
  client = server.accept
  request_line = client.gets
  next if !request_line || request_line =~ /favicon/

  method, path, params, scheme = parse_request(request_line)
  next if method != "GET" || !path.start_with?('/') || !scheme.upcase.start_with?('HTTP')

  client.puts "HTTP/1.1 200 OK"
  client.puts "Content-Type: text/html\r\n\r\n"
  client.puts
  client.puts "<html>"
  client.puts "<body>"
  # client.puts "<pre>"
  # client.puts method, path, params, scheme
  # client.puts "</pre>"
  number = params["number"] ? params["number"] : 0
  client.puts "<h1> Counter </h1>"
  client.puts "The current number is: #{number}"
  client.puts "<p></p>"
  client.puts "<a href='?number=#{number + 1}'>Increase number by 1</a>"
  client.puts "<p></p>"
  client.puts "<a href='?number=#{number - 1}'>Decrease number by 1</a>"
  client.puts "</body>"
  client.puts "</html>"
  client.close
end