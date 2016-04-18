input_data_file    = ARGV[0].nil? ? "discnt.in" : ARGV[0]
output_result_file = ARGV[1].nil? ? "discnt.out" : ARGV[1]

product_prices     = File.open(input_data_file) { |f| f.readline }.split(" ").map(&:to_i)
DISCOUNT           = File.open(input_data_file).each_line.take(2).last.to_i / 100.0

total_price = 0

def mergesort(array)
    if array.count <= 1
      return array
    end

    mid = array.count / 2
    part_a = mergesort array.slice(0, mid)
    part_b = mergesort array.slice(mid, array.count - mid)

    array = []
    offset_a = 0
    offset_b = 0
    while offset_a < part_a.count && offset_b < part_b.count
        a = part_a[offset_a]
        b = part_b[offset_b]

        if a <= b
            array << a
            offset_a += 1
        else
            array << b
            offset_b += 1
        end
    end

    while offset_a < part_a.count
        array << part_a[offset_a]
        offset_a += 1
    end

    while offset_b < part_b.count
        array << part_b[offset_b]
        offset_b += 1
    end

    return array
end


def discover_best_min_amount(sorted_prices)
  purchase_step, total_amount = 0, 0

  sorted_prices.each do |index|

    if purchase_step.eql?(2)
      price = sorted_prices.delete_at(sorted_prices.size - 1)
      total_amount += (price - (price * DISCOUNT)).round(2)
      break
    else
      total_amount += sorted_prices.delete_at(0).round(2)
    end

    purchase_step += 1
  end

  total_amount
end

sorted_prices = mergesort(product_prices)

while sorted_prices.any? do
  total_price += discover_best_min_amount(sorted_prices)
end

#dirty hack
total_price = total_price.to_s
total_price += "0"

File.open(output_result_file, 'w') { |f| f.write(total_price) }


