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
    print "Do you want to [F]IND or [R]EGISTER? "
    input = gets.chomp

    case input
    when 'f' then get_request
    when 'r' then post_request
    end
  end

  def response_to(request)
    socket = TCPSocket.open(hostname, port)
    socket.print(request)
    response = socket.read
    socket.close
    response
  end

  def get_request
    path = '/index.html'
    request = "GET #{path} #{http_ver}\r\n\r\n"

    puts response_to(request)
  end

  def post_request
    puts "You are registering a Knip"
    options = {}
    print "Please enter a name: "
    options[:name] = gets.chomp
    print "Please enter an email address: "
    options[:email] = gets.chomp
    data = {knip: options}.to_json

    path = '/thanks.html'
    
    headers = {}
    headers['Content-type'] = 'application/json'
    headers['Content-length'] = data.bytesize.to_s
    request = "POST #{path} #{http_ver}\r\n"
    headers.each { |header, value| request << "#{header}: #{value}\r\n"}
    request << "\r\n#{data}"

    response = response_to(request)
    puts response
  end
end

browser = Browser.new
browser.run