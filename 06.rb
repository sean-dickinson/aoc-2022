module Day06
  class Buffer
    attr_reader :stream, :window_size
    def initialize(stream, window_size = 4)
      @stream = stream
      @window_size = window_size
    end

    def start_index
      find_index + window_size
    end

    private

    def find_index
      each_window.find_index { |window| window.size == window.uniq.size }
    end

    def each_window
      stream.each_char.each_cons(window_size)
    end
  end

  class << self
    def part_one(input)
      buffer = Buffer.new(input.first)
      buffer.start_index
    end

    def part_two(input)
      buffer = Buffer.new(input.first, 14)
      buffer.start_index
    end
  end
end
