module Day01
  class GroupedList
    include Enumerable
    def initialize(raw_input)
      @raw_input = raw_input
    end

    def each
      # See method here https://ruby-doc.org/3.1.3/Enumerable.html#method-i-chunk_while
      @raw_input.chunk_while { |_line, next_line| next_line != "" }
        .each do |list|
          yield list.reject(&:empty?)
        end
    end
  end

  class Items
    class << self
      def from(raw_text_list)
        GroupedList.new(raw_text_list).map { |list| new(list) }
      end
    end

    def initialize(items)
      @items = convert_to_ints(items)
    end

    def total
      @items.sum
    end

    private

    def convert_to_ints(items)
      return items if items.all? { |item| item.is_a?(Integer) }
      items.map(&:to_i)
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
