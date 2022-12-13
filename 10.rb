module Day10

  class CycleLogger
    attr_reader :logs
    def initialize
      @logs = []
    end

    def count
      @logs.count
    end

    def log(value)
      @logs << value
    end

    def get_value_at(cycle)
      @logs[cycle - 1]
    end
  end

  class Register
    attr_reader :value
    def initialize(logger = CycleLogger.new)
      @value = 1
      @logger = logger
    end

    def cycle_count
      @logger.count
    end

    def noop
      tick
    end

    def addx(x)
      tick
      tick
      @value += x.to_i
    end

    private

    def tick
      @logger.log(value)
    end
  end

  class Renderer
    def initialize(logs)
      @logs = logs
    end

    def render
      result = 6.times.map { |row|
        40.times.map { |position| pixel(row, position) }.join("")
      }.join("\n")
      "\n" + result + "\n"
    end

    def pixel(row, position)
      index = index_from(row, position)
      if sprite_positions(index).include?(position)
        "#"
      else
        "."
      end
    end

    private

    def sprite_positions(i)
      middle = @logs[i]
      (middle - 1)..(middle + 1)
    end

    def index_from(row, position)
      (row * 40) + position
    end
  end

  class << self
    def part_one(input)
      logger = CycleLogger.new
      register = Register.new(logger)
      input.each do |line|
        register.send(*parse_line(line))
      end
      
      cycles = [20, 60, 100, 140, 180, 220]

      cycles.sum do |cycle_num|
        signal_strength(cycle_num, logger.get_value_at(cycle_num))
      end
    end

    def part_two(input)
      logger = CycleLogger.new
      register = Register.new(logger)
      input.each do |line|
        register.send(*parse_line(line))
      end
      Renderer.new(logger.logs).render
    end

    private


    def parse_line(line)
      line.split
    end

    def signal_strength(cycle, value)
      cycle * value
    end
  end
end
