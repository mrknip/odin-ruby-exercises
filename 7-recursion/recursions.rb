# Some exercises with recursive functions

# appends integers from n down to 0 to an array
def append(ary, n)
  return (ary << 0) if n == 0
  
  ary << n 
  knappend(ary, n-1)
end

# appends integers from 0 up to n
def rev_append(ary, n)
  n > 0 ? (rev_append(ary, n-1) << n) : ary << 0 
  if n > 0
    rev_append(ary, n-1) << n
  else
    ary << 0
  end
end

def factorial(n)
  return 1 if n <= 1
  factorial(n-1) * n
end

# determines whether string is a palindrome
def palin(str)
  return false unless str[0] == str[-1]
  palin(str[1..-2]) if str.size > 2
  true
end

# sings a song
def bottles(n)
  if n == 0 
    puts 'no more bottles of beer on the wall'
    return
  else
    puts "#{n} more bottle" << (n==1 ? " " : "s ") << "of beer on the wall" 
    bottles(n-1)
  end
end

# fibonacci generator
def fib(n)
  n < 2 ? (return n) : fib(n-2) + fib(n-1)
end

# flatten array function
def flat(ary, ans=[])
  ary.each do |x|
    if x.is_a? Array
      flat(x, ans)
    else
      ans << x
    end
  end
  ans
end

roman_mapping = {
  1000 => "M",
  900 => "CM",
  500 => "D",
  400 => "CD",
  100 => "C",
  90 => "XC",
  50 => "L",
  40 => "XL",
  10 => "X",
  9 => "IX",
  5 => "V",
  4 => "IV",
  1 => "I"
  }

# given hashmap, converts number to numeral
def numeralise!(num, ans="", mapping = roman_mapping)
  return ans if num == 0
  
  mapping.keys.each do |key_num|
    next unless key_num <= num
    quotient, modulus = num.divmod(key_num)
    ans << (mapping[key_num] * quotient)
    return numeralise!(modulus, ans) if quotient > 0
  end
end

# given hashmap, converts numerals to numbers
def numberise!(numeral, ans=0, mapping = roman_mapping)
  return ans if numeral.empty?

  mapping.values.each do |roman_num|
      while numeral[0..roman_num.size-1] == roman_num
        ans += mapping.key(roman_num)
        numeral = numeral[roman_num.size..-1]
      end
   end
  return numberise!(numeral, ans)
end

# mergesort algorithm
def mergesort(ary)
  return ary if ary.size == 1

  ary_l = mergesort(ary[0...ary.size/2])
  ary_r = mergesort(ary[ary.size/2..-1])

  merge ary_l, ary_r
end

def merge(ary1, ary2, ary_m = [])
  until ary1.empty? && ary2.empty?
    
    if ary1.empty? 
      ary_m << ary2.shift
    elsif ary2.empty? 
      ary_m << ary1.shift
    else 
      ary1[0] < ary2[0] ? ary_m << ary1.shift : ary_m << ary2.shift
    end
  end
  ary_m
end

