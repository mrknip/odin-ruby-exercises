require 'csv'
puts "Event Manager initalised!"

contents = CSV.readlines "../event_attendees.csv", headers: true, header_converters: :symbol

def print_attendees(contents)
  contents.each do |row|
  name = row[:first_name].downcase.capitalize
  zipcode = clean_zipcode(row[:zipcode])
  phone = clean_phone(row[:homephone])

  puts "#{name}\t#{zipcode}\t#{phone}"
end

def most_active_hour(contents)
  hours = parse_dates(contents, :hours)

  mode(hours)
end

def most_active_day(contents)
  days = parse_dates(contents, :days)
  
  mode(days)
end

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, "0")[0..4]
end

def clean_phone(phone)
  mob = phone.to_s.gsub(/\W+|/, "")

  mob = "" unless mob.size.between?(10,11)  
  mob = mob[1..-1] if phone.size == 11 && mob[0] == "1"

  mob.rjust(10, "0").insert(6, "-").insert(3, ") ").insert(0, "(")
end

def mode(array)
  freq = array.inject({}) do |h,v| 
    h[v] ||= 0
    h[v] += 1
    h
  end
  max = freq.values.max
  freq.select {|k,f| f == max }.keys

end

def parse_dates(contents, mode = :none)
  dates = contents.collect {|row| DateTime.strptime(row[:regdate], '%m/%d/%Y %H:%M') }

  case mode
  when :none
    dates
  when :hours
    dates.collect { |date| date.hour }
  when :days
    dates.collect { |date| date.strftime('%A') }
  end
end

puts  most_active_hour(contents)
puts most_active_day(contents)
