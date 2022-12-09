module Day07
  class File
    attr_reader :name, :size
    attr_accessor :parent
    def initialize(input)
      @name = extract_name(input)
      @size = extract_size(input)
    end

    private

    def extract_name(input)
      input.split.last
    end

    def extract_size(input)
      input.split.first.to_i
    end
  end

  class Directory
    attr_reader :name, :contents
    attr_accessor :parent
    def initialize(name)
      @name = name
      @contents = []
    end

    def add(file_or_folder)
      return if already_contains?(file_or_folder)
      contents << file_or_folder
      file_or_folder.parent = self
    end

    def size
      contents.sum(&:size)
    end

    def get_dir(name)
      contents.find do |file_or_folder|
        file_or_folder.is_a?(Directory) && file_or_folder.name == name
      end
    end

    private

    def already_contains?(file_or_folder)
      contents.any? do |f|
        f.name == file_or_folder.name && f.instance_of?(file_or_folder.class)
      end
    end
  end

  class Filesystem
    class << self
      def from(input)
        root_directory = Day07::Directory.new("/")
        filesystem = new(root_directory)
        input.each do |line|
          next if line.start_with? "$ ls"
          filesystem.parse(line)
        end
        filesystem
      end
    end

    attr_reader :cwd, :root_dir, :all_directories
    def initialize(root_dir, cwd = nil)
      @root_dir = root_dir
      @cwd = cwd || root_dir
      @all_directories = []
      @all_directories << cwd unless cwd.nil?
    end

    def parse(line)
      if line.start_with? "$"
        cd(line.split.last)
      else
        add(line)
      end
    end

    def cd(dir_name)
      @cwd = special_values[dir_name] || cwd.get_dir(dir_name)
    end

    def add(file_or_folder)
      if file_or_folder.start_with? "dir"
        folder = Directory.new(file_or_folder.split.last)
        cwd.add(folder)
        all_directories << folder
      else
        cwd.add(File.new(file_or_folder))
      end
    end

    private

    def special_values
      {
        ".." => cwd.parent,
        "/" => root_dir
      }
    end
  end

  class << self
    TOTAL_SPACE = 70000000
    SPACE_NEEDED = 30000000
    def part_one(input)
      filesystem = Filesystem.from(input)

      filesystem.all_directories
        .filter { |dir| dir.size <= 100000 }
        .sum(&:size)
    end

    def part_two(input)
      filesystem = Filesystem.from(input)
      space_used = filesystem.root_dir.size
      current_free_space = TOTAL_SPACE - space_used
      filesystem.all_directories
        .filter { |dir| (current_free_space + dir.size) >= SPACE_NEEDED }
        .min_by(&:size)
        .size
    end
  end
end
