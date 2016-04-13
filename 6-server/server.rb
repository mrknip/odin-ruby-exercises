require 'socket'
require 'json'


class Server
  attr_reader :server, :client
  
  def initialize(port = 2000)
    @server = TCPServer.open(port)
    @client = ""
    @base = "C:/users/Drew/documents/coding/ruby/odin/odin-exercises/6-server"
    @resp_headers = {}
  end

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
    req_line = req_headers.first
    method, path, version = req_line.split
    [method, path, version]
  end

  def parse_header_data(req_headers)
    req_header_hsh = {}
    req_headers[1..-1].each do |req_header|
      type, value = req_header.split(": ")
      req_header_hsh[type] = value.strip
    end
    req_header_hsh
  end

  def run
    puts "SERVER INITIALISED"
    loop do
      client = server.accept
      
      req_headers = parse_headers(client)
      method, path, version = parse_first_line(req_headers)
      req_header_data = parse_header_data(req_headers)

      if method == "GET"
        p "GET request received"

        body = ""
        headers = {}
        path = "#{@base}#{path}"
        
        if File.exists? path
          code, reason = "200", "OK"

          File.foreach(path, "r") do |line|
            body << line
          end

          headers['Date'] = Time.now
          headers['Content-Type'] = 'text/html'
          headers['Content-Length'] = body.bytesize.to_s
        else
          code = "404"
          reason = "NOT FOUND"
          p "#{path} not found"
        end
      
        # building response   
        response = ""
        response << "#{version} #{code} #{reason}\r\n"
        headers.each { |header, value| response << "#{header}: #{value}\r\n"}
        response << "\r\n"
        response << body

        client.print response
      elsif method == "POST"
        puts "POST request received"
        body = client.read(req_header_data['Content-length'].to_i)
        params = JSON.parse(body)
        
        post_html = File.read("#{@base}/thanks.html")

        list = ""
        params.each do |type, content|
          puts type
          content.each do |field, data|
              list << "\t\t<li>#{field}: #{data}</li>\n"
          end
        end
        post_html.gsub!("\t\t<%= yield %>", list.chomp)

        client.puts post_html

        code = 200
        reason = "OK"
        resp_headers = {}

        resp_headers['Date'] = Time.now
        resp_headers['Content-Type'] = 'text/html'
        resp_headers['Content-Length'] = post_html.bytesize.to_s

        response = ""
        response << "#{version} #{code} #{reason}\r\n"
        resp_headers.each { |header, value| response << "#{header}: #{value}\r\n"}
        response << "\r\n"
        response << post_html

        client.print response
      else
        p "Do not understand method"
      end

      client.close  
    end
  end
end

s = Server.new
s.run