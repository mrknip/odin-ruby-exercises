def caesar_cipher(string, key)
  characters = string.split("")

  characters.each_with_index do |char, index|
    ascii_value = char.ord

    next if !(char =~ /[A-Za-z]/)

    key.abs.times do
      if key > 0
        ascii_value += 1
        ascii_value -= 26 if ascii_value == 91 || ascii_value == 123
      elsif key < 0
        ascii_value -=1
        ascii_value += 26 if ascii_value == 64 || ascii_value == 96
      end
    end

    characters[index] = ascii_value.chr
  end
  return characters.join("")
end

# p 
# p caesar_cipher(, -5)
# p caesar_cipher("What a string!", 349587)
# p caesar_cipher("Nyrk r jkizex!", -349587)
