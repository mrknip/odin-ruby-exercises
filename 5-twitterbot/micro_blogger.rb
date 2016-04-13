require 'jumpstart_auth'

ENV['SSL_CERT_FILE'] = 'C:\dev\cacert.pem'

class Microblogger
  attr_reader :client

  def initialize
    puts "Initializing Microblogger"
    @client = JumpstartAuth.twitter
  end

  def run
    puts "Welcome to the tweet machine"

    command = ""

    while command != 'q'
      print "enter command: "
      input = gets.chomp

      parts = input.split
      command = parts.shift
      target = parts.shift if command == 'dm'
      message = parts.join(" ")
    
      case command
      when 'dm' then dm(target, message)
      when 'last' then all_last_tweets
      when 'spam' then spam_my_followers(message)
      when 't' then tweet(message)
      when 'q' then puts "Goodbye!"
      else
        puts "Sorry, I don't know how to #{command}"
      end
    end
  end

  def tweet(message)
    if message.length <= 140
      client.update(message)
    else
      puts "Message must be less than 140 characters"
    end
  end

  def dm(target, message)
    puts "Trying to send @#{target} this message"
    puts message
    
    if followers_list.include? target
      message = "d @#{target} #{message}"
      tweet(message)
      puts "Message sent to @#{target}"
    else 
      puts "#{target} is not a follower"
    end
  end 

# TBC - Blocked as broke API rate limit
def all_last_tweets
  tweets = {}

  friends = client.friends.to_a.collect { |friend_id| client.user(friend_id) }
  
  p friends
  friends.sort_by { |friend| friend.screen_name.downcase }
  p friends

  # friends.each do |friend|
  #   tweets[friend.screen_name] ||= friend.status.text
  # end

  # p tweets 
  # tweets = Hash[tweets.sort_by { |name, tweet| name }]
  # p tweets

  # tweets.each do |name, tweet|
  #   puts "#{name} said..."
  #   puts "\t #{tweet}"
  # end
end

def followers_list
  client.followers.collect {|follower| @client.user(follower).screen_name }
end

def spam_my_followers(message)
  followers_list.each { |follower| dm(follower, message) }
end

end

blogger = Microblogger.new
blogger.run