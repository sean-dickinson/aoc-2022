require "./11"
module Day13
  class Packet
    attr_reader :list
    def initialize(list)
      @list = list
    end

    def ==(other)
      list == other.list
    end

    def <=>(other)
      return 0 if self == other
      if self < other
        -1
      else
        1
      end
    end

    def <(other)
      compare_arrays(list, other.list)
    end

    private

    def zipped_lists(left, right)
      filled_list(left, right).zip(right)
    end

    def filled_list(left, right)
      filled_list = left.clone
      size_diff = right.size - left.size
      if size_diff > 0
        filled_list.fill(nil, left.size, size_diff)
      end
      filled_list
    end

    def compare(left, right)
      if left.instance_of?(right.class)
        compare_same(left, right)
      else
        compare_different(left, right)
      end
    end

    def compare_same(left, right)
      if left.instance_of?(Integer)
        compare_integers(left, right)
      else
        compare_arrays(left, right)
      end
    end

    def compare_arrays(left_list, right_list)
      zipped_lists(left_list, right_list).each do |left, right|
        result = compare(left, right)
        next unless [true, false].include?(result)
        return result
      end
    end

    def compare_integers(left, right)
      if left == right
        nil
      else
        left < right
      end
    end

    def compare_different(left, right)
      if left.nil? || right.nil?
        compare_nil(left, right)
      else
        convert_and_compare(left, right)
      end
    end

    def convert_and_compare(left, right)
      if left.instance_of?(Integer)
        compare_arrays([left], right)
      else
        compare_arrays(left, [right])
      end
    end

    def compare_nil(left, right)
      left.nil?
    end
  end

  class << self
    def part_one(input)
      pairs(input).map.with_index(1).sum do |pair, index|
        if pair[0] < pair[1]
          index
        else
          0
        end
      end
    end

    def part_two(input)
      # debug(input)
      all_packets(input)
        .sort
        .map
        .with_index(1)
        .select { |p, _i| divider_packets.include?(p) }
        .map(&:last)
        .inject(1, :*)
    end

    private

    def pairs(input)
      Day11::InputChunker.new(input)
        .chunks
        .map { |line_1, line_2| [Packet.new(eval(line_1)), Packet.new(eval(line_2))] }
    end

    def all_packets(input)
      pairs(input).to_a.flatten + divider_packets
    end

    def debug(input)
      File.open("./13_debug.txt", "w") do |f|
        all_packets(input)
          .sort
          .each do |packet|
            f << packet.list.to_s
            f << "\n"
          end
      end
    end

    def divider_packets
      [
        Packet.new([[2]]),
        Packet.new([[6]])
      ]
    end
  end
end
