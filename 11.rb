module Day11
  class Monkey
    class << self
      def gcm
        descendants.map(&:divisor).inject(1, :*)
      end

      def reset_descendants
        @_descendants = nil
      end

      private

      def descendants
        @_descendants ||= ObjectSpace.each_object(self).to_a
      end
    end

    attr_reader :items, :inspection_count, :decrease_worry
    attr_accessor :receivers
    def initialize(items = [], decrease_worry = true)
      @items = items
      @inspection_count = 0
      @receivers = []
      @decrease_worry = decrease_worry
    end

    def turn
      until items.empty?
        item = items.shift
        modified_item = inspect(item)
        modified_item = if decrease_worry
          (modified_item / 3.to_f).floor
        else
          modified_item %= self.class.superclass.gcm
        end
        receiver = choose_receiver(modified_item)
        throw_to(receiver, modified_item)
      end
    end

    def inspect(item)
      @inspection_count += 1
      operation(item)
    end

    def throw_to(receiver, item)
      receiver.receive(item)
    end

    def receive(thrown_item)
      @items << thrown_item
    end

    def divisor
      1
    end

    private

    def operation(item)
      item
    end

    def choose_receiver(item)
      if item % divisor == 0
        @receivers.first
      else
        @receivers.last
      end
    end
  end

  class MonkeyFactory
    ITEMS_INDEX = 1
    OPERATION_INDEX = 2
    CHECK_INDEX = 3
    RECEIVER_1_INDEX = 4
    RECEIVER_2_INDEX = 5
    class << self
      def create_monkey(input, index, no_worry = false)
        monkey_class = create_class(input)
        monkey_class.new(extract_items(input), index, !no_worry)
      end

      def get_receivers(monkeys, input)
        indicies = extract_receiver_indicies(input)
        receivers = []
        indicies.each do |i|
          receivers << monkeys[i]
        end
        receivers
      end

      private

      def create_class(input)
        divisor = extract_divisor(input)
        operation = extract_operation(input)
        Class.new(Monkey) do
          attr_reader :index
          def initialize(items, index, decrease_worry = true)
            super(items, decrease_worry)
            @index = index
          end

          define_method(:divisor, -> { divisor })

          private

          define_method(:operation, operation)
        end
      end

      def extract_items(input)
        items_string = input[ITEMS_INDEX].split(":").last
        items_string.split(",").map(&:to_i)
      end

      def extract_divisor(input)
        input[CHECK_INDEX].split.last.to_i
      end

      def extract_operation(input)
        op, num = input[OPERATION_INDEX].split.last(2)
        if num == "old"
          ->(old) { old.send(op, old) }
        else
          ->(old) { old.send(op, num.to_i) }
        end
      end

      def extract_receiver_indicies(input)
        first = input[RECEIVER_1_INDEX].split.last.to_i
        second = input[RECEIVER_2_INDEX].split.last.to_i
        [first, second]
      end
    end
  end

  class InputChunker
    def initialize(input)
      @input = input
    end

    def chunks
      @input.chunk { |line| (line == "") ? nil : true }
        .map(&:last)
    end
  end

  class << self
    def part_one(input)
      monkeys = get_monkeys(input)
      20.times do
        monkeys.each do |monkey|
          monkey.turn
        end
      end
      monkey_business(monkeys)
    end

    def part_two(input)
      Monkey.reset_descendants
      monkeys = get_monkeys(input, true)
      10000.times do |index|
        monkeys.each do |monkey|
          monkey.turn
        end
      end
      monkey_business(monkeys)
    end

    private

    def monkey_business(monkeys)
      top_monkeys = monkeys.map(&:inspection_count).sort.last(2).reverse
      top_monkeys.reduce(1, :*)
    end

    def get_monkeys(input, no_worry = false)
      monkeys = []
      input_chunks = chunks(input)
      input_chunks.each_with_index do |chunk, index|
        monkeys << MonkeyFactory.create_monkey(chunk, index, no_worry)
      end

      input_chunks.each_with_index do |chunk, index|
        monkeys[index].receivers = MonkeyFactory.get_receivers(monkeys, chunk)
      end
      monkeys
    end

    def chunks(input)
      InputChunker.new(input).chunks
    end
  end
end
