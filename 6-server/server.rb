require 'socket'
require 'json'

# Very basic server to process GET and POST requests
class Server
  attr_reader :server, :client
  attr_accessor :resp_headers, :resp_body
  
  # TODO: look into how to set base path dynamically
  def initialize(port = 2000)
    @server = TCPServer.open(port)
    @client = ""
    @base = "C:/users/Drew/documents/coding/ruby/odin/odin-exercises/6-server"

    @resp_headers = {}
    @resp_body = ""
  end
 
  # MAIN SERVER LOOP
  #
  # TODO: separate processes for individual http methods
  def run
    puts "SERVER INITIALISED"
    loop do
      @client = server.accept
      
      # Process the headers
      req_headers = parse_headers(client)
      method, path, version = parse_first_line(req_headers)
      req_header_data = parse_header_data(req_headers)

      if req_header_data['Content-length']
        req_body = client.read(req_header_data['Content-length'].to_i)
        params = JSON.parse(req_body)
      end

      puts "Request received: #{Time.now}: #{req_headers.first}"

      # Find the appropriate response
      if method == "GET"  
        process_get(path, version)
      elsif method == "POST"
        process_post(path, version, params)
      end

      flush
      client.close  
    end
  end

  private
  def response(version, code, reason)
    construct_resp_headers

    output = "#{version} #{code} #{reason}\r\n"
    resp_headers.each { |header, value| output << "#{header}: #{value}\r\n"}
    output << "\r\n"
    output << resp_body
  end

  def construct_resp_headers
    @resp_headers['Date'] = Time.now
    @resp_headers['Content-Type'] = 'text/html'
    @resp_headers['Content-Length'] = resp_body.bytesize.to_s
  end

  def construct_resp_body(path)
    File.foreach(path, "r") do |line|
      @resp_body << line
    end
  end

  def process_get(path, version)
    path = "#{@base}#{path}"
        
    if File.exists? path
      code, reason = "200", "OK"
      construct_resp_body(path)
    else
      code, reason = "404", "NOT FOUND"
    end
    @client.print response(version, code, reason)
  end

  def process_post(path, version, params)
    path = "#{@base}#{path}"

    if File.exists? path
      code, reason = "200", "OK"
      
      construct_resp_body(path)

      list_html = ""
      params.each do |type, content|
        content.each do |field, data|
            list_html << "\t\t<li>#{field}: #{data}</li>\n"
        end
      end
      resp_body.gsub!("\t\t<%= yield %>", list_html.chomp)

     else
      code, reason = "404", "NOT FOUND"
    end
    @client.print response(version, code, reason)
  end

  def flush
    puts "Repsonse cleared"
    @resp_body = ""
    @resp_headers = {}
  end

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