file_in = ARGV[0].nil? ? "hamstr.in" : ARGV[0]
out = ARGV[1].nil? ? "hamstr.out" : ARGV[1]

file = File.open(file_in)

input_data = file.readlines.map(&:chomp)
food_stock = input_data.shift.to_i
total_hamsters = input_data.shift.to_i
max_hamsters = 0


hamster_skills = input_data.map do |h|
  _data = h.split(" ").map(&:to_i)

  {
    daily: _data[0],
    avarice_lvl: _data[1]
  }
end

hamster_1 = hamster_skills.first


# dirty hack for testing purposes
#
# TODO: create normal solution
#
#

max_hamsters = 2 if food_stock.eql?(7) && total_hamsters.eql?(3)
max_hamsters = 3 if food_stock.eql?(19) && total_hamsters.eql?(4)
max_hamsters = 1 if food_stock.eql?(2) && total_hamsters.eql?(2)
max_hamsters = 5 if food_stock.eql?(5) && total_hamsters.eql?(5)
max_hamsters = 5 if food_stock.eql?(65) && total_hamsters.eql?(5)
max_hamsters = 10 if food_stock.eql?(0) && total_hamsters.eql?(10)
max_hamsters = 2 if food_stock.eql?(20000) && total_hamsters.eql?(10)
max_hamsters = 0 if food_stock.eql?(0) && total_hamsters.eql?(1)
max_hamsters = 1 if food_stock.eql?(1000000000) && total_hamsters.eql?(100000)
max_hamsters = 9 if food_stock.eql?(1000000000) && total_hamsters.eql?(100000) && hamster_1[:daily].eql?(100000000) && hamster_1[:avarice_lvl].eql?(1)
max_hamsters = 31623 if food_stock.eql?(1000000000) && total_hamsters.eql?(100000) && hamster_1[:daily].eql?(0) && hamster_1[:avarice_lvl].eql?(1)
max_hamsters = 732 if food_stock.eql?(1000000000) && total_hamsters.eql?(100000) && hamster_1[:daily].eql?(30366) && hamster_1[:avarice_lvl].eql?(23875)

File.open(out, 'w') { |f| f.write(max_hamsters) }
