module Day01



  class Items

    class << self
      def from(raw_text_list)
        items = []
        item_list = []
        raw_text_list.each do |line|
          if line == ""
            items << new(item_list.map.to_a)
            item_list = []
            next
          end
          item_list << line.to_i
        end
        items << new(item_list.map.to_a) if item_list.size > 0
        items
      end
    end

    def initialize(items)
      @items = items
    end

    def to_s
      @items.to_s
    end

    def total
      @items.sum
    end

  end

  class << self
    def part_one(input)
      Items.from(input).map(&:total).max
    end

    def part_two(input)
      Items.from(input).map(&:total).sort.reverse.first(3).sum
    end
  end
end
