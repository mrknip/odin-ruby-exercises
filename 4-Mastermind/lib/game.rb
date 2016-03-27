require_relative 'codesetter'

class Game

  attr_reader :codesetter, :codebreaker

  def initialize(options = {codesetter: Codesetter.new, 
                           codebreaker: :human, 
                                 input: $stdin})

    @codesetter = options[:codesetter]
    @codebreaker = options[:codebreaker]
    @input = options[:input]
  end

  def setup(n = 4)
    @codesetter.set_code(n)
    @guesses = []
    @responses = []
    @turn = 1
  end

  def get_colour
    loop do
      puts "\nEnter: [R]ed, [B]lue, [G]reen, [Y]ellow, [P]urple or [O]range"
      input = @input.gets.chomp.downcase
      unless Codesetter::COLOURS.values.include? input
        p "Please enter a valid guess" 
        redo
      end
      return to_colour(input)
    end
  end

  def to_colour(string)
    Codesetter::COLOURS.key(string)
  end

  def get_guess
    guess = []
    @codesetter.code.size.times do
      guess << get_colour
    end
    guess
  end

  def check_against_code(guess)
    codesetter.check_guess(guess)
  end

  def display
    puts "Turn #{@turn}"
    (0..(@turn-1)).each do |i|
      print "Guess #{@guesses[i]}  ||  #{@responses[i]}\n"
    end
  end

  def end_game(result)
    case result
    when :win then puts "Code breaker wins!"
    when :draw then puts "Code setter wins!"
    end
    exit
  end

  def win?
    @responses[-1].all? {|r| r == :black} && @responses[-1].size == 4
  end

  def play
    system('cls')
    setup
    while @turn <= 12
      @guesses << get_guess
      system('cls')
      p @guesses
      @responses << check_against_code(@guesses[-1])
      p @guesses
      p @codesetter.code
      display
      end_game(:win) if win?
      @turn += 1
    end
    end_game(:draw)
  end
end