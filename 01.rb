module Day01
  class Items
    class << self
      def from(raw_text_list)
        # See method here https://ruby-doc.org/3.1.3/Enumerable.html#method-i-chunk_while
        raw_text_list.chunk_while { |line, next_line| next_line != "" }
          .map { |list| list.reject(&:empty?).map(&:to_i) }
          .map { |list| new(list) }
      end
    end

    def initialize(items)
      @items = items
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
      Items.from(input).map(&:total).sort.last(3).reverse.sum
    end
  end
end
