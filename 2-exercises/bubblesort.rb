def bubble_sort(array)

  final_run = false
  sorted_array = array.dup

  until final_run 

    final_run = true
    
    sorted_array.each_index do |i|
      next if sorted_array[i+1] == nil
      
      if sorted_array[i] > sorted_array[i+1]
        sorted_array[i], sorted_array[i+1] = sorted_array[i+1], sorted_array[i]
        final_run = false
      end
      
    end
  end

  return sorted_array

end

p bubble_sort([4,3,78,2,0,2])

def bubble_sort_by(array)

  final_run = false
  sorted_array = array.dup

  until final_run
    
    final_run = true
    
    sorted_array.each_index do |i|
      next if sorted_array[i+1].nil?
      
      if (yield sorted_array[i], sorted_array[i + 1]) > 0
        sorted_array[i], sorted_array[i + 1] = sorted_array[i + 1], sorted_array[i]
        final_run = false
      end
    end
  end
  
  return sorted_array 
end

p bubble_sort_by(["Hi", "Hello", "Hey"]) {|left, right| left.length - right.length}
