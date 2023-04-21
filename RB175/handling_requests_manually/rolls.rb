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
  if params["rolls"] && params["sides"]
    client.puts "<h1>Rolls!</h1>"
    params["rolls"].times { client.puts "<p>#{rand(1..params["sides"])}</p>" }
  end
  client.puts "</body>"
  client.puts "</html>"
  client.close
end