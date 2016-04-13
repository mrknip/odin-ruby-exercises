require 'socket'
require 'json'

# Very basic server to process GET and POST requests
class Server
  attr_reader :server, :client, :resp_headers, :resp_body
  
  # TODO: look into how to set base path dynamically
  def initialize(port = 2000)
    @server = TCPServer.open(port)
    @client = ""
    @base = "C:/users/Drew/documents/coding/ruby/odin/odin-exercises/6-server"

    @resp_headers = {}
    @resp_body = ""
  end

  def run
    puts "SERVER INITIALISED"
    loop do
      client = server.accept
      
      # Process the headers
      req_headers = parse_headers(client)
      method, path, version = parse_first_line(req_headers)
      req_header_data = parse_header_data(req_headers)

      # Find the appropriate response
      if method == "GET"
        puts "Request received: #{Time.now}: #{req_headers.first}"

        path = "#{@base}#{path}"
        
        if File.exists? path
          code, reason = "200", "OK"

          resp_body = ""
          File.foreach(path, "r") do |line|
            resp_body << line
          end

          resp_headers = {}
          resp_headers['Date'] = Time.now
          resp_headers['Content-Type'] = 'text/html'
          resp_headers['Content-Length'] = resp_body.bytesize.to_s
        else
          code, reason = "404", "NOT FOUND"
        end
      
        # building response   
        response = ""
        response << "#{version} #{code} #{reason}\r\n"
        resp_headers.each { |header, value| response << "#{header}: #{value}\r\n"}
        response << "\r\n"
        response << resp_body

        client.print response
      elsif method == "POST"
        puts "Request received: #{Time.now}: #{req_headers.first}"
        
        path = "#{@base}#{path}"

        if File.exists? path
          code, reason = "200", "OK"
        
          req_body = client.read(req_header_data['Content-length'].to_i)
          params = JSON.parse(req_body)
        
          list_html = ""
          params.each do |type, content|
            content.each do |field, data|
                list_html << "\t\t<li>#{field}: #{data}</li>\n"
            end
          end

          resp_body = ""
          resp_body = File.read(path)
          resp_body.gsub!("\t\t<%= yield %>", list_html.chomp)
        else
          resp_body = ""
          code, reason = "404", "NOT FOUND"
        end
        
        resp_headers = {}

        resp_headers['Date'] = Time.now
        resp_headers['Content-Type'] = 'text/html'
        resp_headers['Content-Length'] = resp_body.bytesize.to_s

        response = ""
        response << "#{version} #{code} #{reason}\r\n"
        resp_headers.each { |header, value| response << "#{header}: #{value}\r\n"}
        response << "\r\n"
        response << resp_body

        client.print response
      else
        p "Do not understand method"
      end

      client.close  
    end
  end

  private
  # Request handling methods
  #
  # These would sit better in a request object.  That would also help for
  # rendering the storing of information consistently - currently there are
  # variables and a hash. Making these attributes of an object would improve
  # flexibility and readability.
  def parse_headers(client)
    req_headers = []
    body = []
    while line = client.gets
      break if line == "\r\n"
      req_headers << line
    end
    req_headers
  end

  def parse_first_line(req_headers)
    req_headers.first.split
  end

  def parse_header_data(req_headers)
    req_header_hsh = {}
    req_headers[1..-1].each do |req_header|
      type, value = req_header.split(": ")
      req_header_hsh[type] = value.strip
    end
    req_header_hsh
  end
end

s = Server.new
s.run