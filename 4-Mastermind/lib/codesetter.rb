class Codesetter

  attr_accessor :code

  COLOURS = {red: "r", blue: "b", green: "g", yellow: "y", purple: "p", orange: "o"}

  def initialize
    @code = set_code(4)
  end

  def set_code(n)
    new_code = []
    n.times do 
      new_code << COLOURS.keys[rand(6)]
    end
    new_code
  end 

  def check_guess(guess)
    matches = []
    check_code = code.dup
    check_guess = guess.dup

    check_colour_and_position!(check_guess, check_code, matches)
    check_colour_only!(check_guess, check_code, matches)
    
    matches
  end

  def check_colour_and_position!(check_guess, check_code, matches)
    check_guess.each_with_index do |guess_colour, guess_index|
      if guess_colour == check_code[guess_index]
        matches << :black
        check_code[guess_index] = :done
        check_guess[guess_index] = :removed
      end
    end 
  end

  def check_colour_only!(check_guess, check_code, matches)
    check_guess.each_with_index do |guess_colour, guess_index|
      code_index = check_code.index { |code_colour| code_colour == guess_colour }
      if code_index
        matches << :white 
        check_guess[guess_index] = :removed
        check_code[code_index] = :done
      end
    end
  end

end