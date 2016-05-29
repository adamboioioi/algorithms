	file_in = ARGV[0].nil? ? "hamstr.in" : ARGV[0]
	out = ARGV[1].nil? ? "hamstr.out" : ARGV[1]

	file = File.open(file_in)

	input_data = file.readlines.map(&:chomp)
	food_stock = input_data.shift.to_i
	$total_hamsters = input_data.shift.to_i
	hamster_skills = input_data.map { |h| h.split(" ").map(&:to_i) }

	def solve(food_stock, hamsters)
	    possible_hamster_counts = 0..(hamsters.size - 1)
	    
	    comparator = lambda { |hamster_count|
	    	get_required_food_for_best_k_hamsters(hamsters, k=hamster_count) > food_stock
	   	} 
	    
	    max_affordable_hamsters = binary_search_rightmost(possible_hamster_counts, comparator)
	    return max_affordable_hamsters
		
	end

	def binary_search_rightmost(sorted_data, comparator, left=nil, right=nil)
	    left = 0 if left.nil?
	        
	    right = sorted_data.size if right.nil?
	        
	    
	    while left < right
	        middle = (left + right + 1) / 2

	        if comparator.call(middle)
	            right = middle - 1
	        else
	            left = middle
	        end

	   	end

	    right
	end

	def quicksort(array)
	    less = []
	    equal = []
	    greater = []

	    return array if array.size <= 1
	        
	    pivot = array[0]
	    
		array.each do |x|

	        less.push(x) if x < pivot
	            
	        equal.push(x) if x == pivot
	            
	        greater.push(x) if x > pivot
	    
	    end
	    quicksort(less) + equal + quicksort(greater)
	end

	def get_required_food_for_best_k_hamsters(hamsters, k)
	    required_food_per_hamster = hamsters.map {|(hunger, greed)| hunger + greed * (k - 1)}
	    required_food_per_hamster = quicksort(required_food_per_hamster)

	    required_food = required_food_per_hamster[0...k].inject(0){|sum,x| sum + x }
	    
	    required_food
	end

	max_hamsters = solve(food_stock, hamster_skills)
	File.open(out, 'w') { |f| f.write(max_hamsters) }


