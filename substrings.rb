def substrings(string, dictionary)
  matches = {}

  dictionary.each do |word|
    next if string.downcase.scan(/#{word.downcase}/) == nil

    string.downcase.scan(/#{word.downcase}/).each do |matched_word|
      matches["#{matched_word}"] ||= 0
      matches["#{matched_word}"] += 1
    end
  end
  return matches
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
p substrings("below", dictionary)
p substrings("Howdy partner, sit down!  How's it going?", dictionary)