require 'socket'
require 'json'

class Browser
  attr_reader :hostname, :port, :http_ver

  def initialize
    @hostname = 'localhost'
    @port = 2000
    @http_ver = "HTTP/1.0"
  end

  def run
    puts "Welcome to hi-tech browser land"
    print "Do you want to [F]IND or [R]EGISTER a knip? "
    input = gets.chomp

    case input
    when 'f' then get_request
    when 'r' then post_request
    end
  end

  def send(request)
    socket = TCPSocket.open(hostname, port)
    socket.print(request)
    response = socket.read
    socket.close
    response
  end

  def get_request
    path = '/index.html'
    request = "GET #{path} #{http_ver}\r\n\r\n"

    response = send(request)
    puts response

    headers, body = response.split("\r\n\r\n", 2)
  end

  def post_request
    puts "You are registering a Knip"
    options = {}
    print "Please enter a name: "
    options[:name] = gets.chomp
    print "Please enter an email address: "
    options[:email] = gets.chomp
    data = {knip: options}.to_json

    path = 'knip/processor'
    
    headers = {}
    headers['Content-type'] = 'application/json'
    headers['Content-length'] = data.bytesize.to_s
    request = "POST #{path} #{http_ver}\r\n"
    headers.each { |header, value| request << "#{header}: #{value}\r\n"}
    request << "\r\n#{data}"

    response = send(request)
    puts response
  end
end

browser = Browser.new
browser.run