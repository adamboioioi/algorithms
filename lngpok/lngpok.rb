input_data_file    = ARGV[0].nil? ? "lngpok.in" : ARGV[0]
output_result_file = ARGV[1].nil? ? "lngpok.out" : ARGV[1]

$cards = File.open(input_data_file) { |f| f.readline }.split(" ").map(&:to_i)
$jockers = 0

def prepare_game_set
  quick($cards, 0, $cards.size - 1)
  $jockers = $cards.select { |card| card.zero? }.size
  $cards.uniq!
  $cards.delete_if { |card| card.zero? }
end

def find_longest_card_set
  set = []
  jockers = $jockers
  previous_card_value = 0

  $cards.each_with_index do |card, index|

    jocker_diff = $jockers - jockers

    if set.empty?
      set << card
      next
    end

    previous_card_value = set[index - 1] + jocker_diff #TODO change index - 1 to last


    if (card - previous_card_value).eql?(1)
      set << card
    elsif jockers.zero?
      return set
    else
      jockers -= 1
      set << previous_card_value + 1

      while (card - set.last) != 1

        break if jockers.zero?
        set << set.last + 1
        jockers -= 1

      end

      set << card if (card - set.last).eql?(1)

    end

  end

  jockers.times do |index| set << index  end unless jockers.zero?
  set

end

def quick(keys, left, right)
  if left < right
    pivot = partition(keys, left, right)
    quick(keys, left, pivot-1)
    quick(keys, pivot+1, right)
  end
  keys
end

def partition(keys, left, right)
  x = keys[right]
  i = left-1
  for j in left..right-1
    if keys[j] <= x
      i += 1
      keys[i], keys[j] = keys[j], keys[i]
    end
  end
  keys[i+1], keys[right] = keys[right], keys[i+1]
  i+1
end

# run scripts
prepare_game_set
longest_set = []

if $cards.empty?
  longest_set = Array.new($jockers)
else
  while $cards.any?
    set = find_longest_card_set
    longest_set = set if longest_set.empty? || set.size > longest_set.size
    $cards.delete_at(0)
    break if longest_set.size > $cards.size
  end
end

File.open(output_result_file, 'w') { |f| f.write(longest_set.size) }
