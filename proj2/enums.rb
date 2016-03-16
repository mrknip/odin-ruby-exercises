require 'pry'

module Enumerable
  def my_each 
    return self unless block_given?
    
    count = 0
    
    while count < self.length
      yield self[count]
      count += 1
    end
    
    return self
  end
    
  def my_each_with_index
    return self unless block_given?
    
    count = 0
    
    while count < self.length
      yield self[count], count
      count += 1
    end
    
    return self
  end

  def my_select
    return self unless block_given?
    
    output = []
    my_each {|i| output << i if yield i}    

    output
  end  
  
  def my_all?
    if block_given?
      my_each { |i| return false unless yield i }
    else
      my_each { |i| return false unless i }
    end
    true
  end
  
  def my_any? 
    if block_given?    
      my_each { |i| return true if yield i }
    else
      my_each { |i| return true if i }
    end
    false
  end

  def my_none?
    if block_given?
      my_each { |i| return false if yield i }
    else
      my_each { |i| return false if i }
    end
    true
  end
  
  def my_count(value = nil)
    count = 0
    
    if block_given?
      my_each { |i| count += 1 if yield i }
      count
    elsif value
      my_each { |i| count += 1 if self[i] == value }
      count
    else
      length
    end
  end

  def my_map
    output = []
    
    if block_given?
      my_each { |i| output << (yield i) }
      output
    else
      return self
    end
  end

  def my_inject(*params)
    enum = self.dup
    
    if block_given?
      enum.unshift(params.first) unless params.empty?
      output = enum.first
      
      enum[1..-1].my_each { |i| output = yield output, i }
    elsif params.size > 0
      raise TypeError, "#{params} is not a symbol or a string" unless params.last.is_a?(Symbol) || params.last.is_a?(String)
      
      enum.unshift(params.first) unless params.first.is_a?(Symbol) || params.first.is_a?(String)
      output = enum.first
      
      eval "enum[1..-1].my_each { |i| output = output #{params.last.to_s} i }"
    else
      raise LocalJumpError, "no block given"
    end
    
    output
  end
  
  def my_map_proc(proc)
    output = []    
    my_each { |i| output << proc.call(i) }
    output
  end

  def my_map_proc_block(proc) 
    raise ArgumentError, "Needs a proc" if proc == nil
    
    output = []
    
    if block_given?
      my_each { |i| output << yield(proc.call(i)) }
    else
      my_each { |i| output << proc.call(i) } 
    end
    
    output
  end
end