require "./07"
describe Day07 do
  describe "File" do
    describe "#new" do
      it "creates a file with name and size from the input" do
        input = "29116 f"
        file = Day07::File.new(input)
        expect(file.name).to eq("f")
        expect(file.size).to eq(29116)
      end
    end
  end

  describe "Directory" do
    describe "#add" do
      it "adds a file to the directory contents" do
        directory = Day07::Directory.new("a")
        file = Day07::File.new("100 f")

        directory.add(file)
        expect(directory.contents).to include(file)
        expect(file.parent).to eq(directory)
      end

      it "does not add a file if a file with that name already exists" do
        directory = Day07::Directory.new("a")
        file = Day07::File.new("100 f")
        same_name_file = Day07::File.new("200 f")

        directory.add(file)

        expect { directory.add(same_name_file) }.not_to change { directory.contents.size }
      end

      it "adds a directory to the directory contents" do
        directory = Day07::Directory.new("a")
        inner_directory = Day07::Directory.new("b")

        directory.add(inner_directory)
        expect(directory.contents).to include(inner_directory)
        expect(inner_directory.parent).to eq(directory)
      end

      it "does not add a directory if a directory with that name already exists" do
        directory = Day07::Directory.new("a")
        inner_directory = Day07::Directory.new("b")

        directory.add(inner_directory)
        expect(directory.contents).to include(inner_directory)

        expect { directory.add(Day07::Directory.new("b")) }.not_to change { directory.contents.size }
      end
    end

    describe "#size" do
      it "returns the size of all files inside the directory" do
        directory = Day07::Directory.new("a")
        [
          Day07::File.new("100 b"),
          Day07::File.new("100 c"),
          Day07::File.new("200 d")
        ].each do |file|
          directory.add(file)
        end

        expect(directory.size).to eq(400)
      end

      it "includes size of all directories and files inside" do
        directory = Day07::Directory.new("a")
        inner_directory = Day07::Directory.new("b")

        [
          Day07::File.new("100 c"),
          Day07::File.new("100 d")
        ].each do |inner_file|
          inner_directory.add(inner_file)
        end

        directory.add(Day07::File.new("100 c"))
        directory.add(inner_directory)

        expect(directory.size).to eq(300)
      end
    end

    describe "#get_dir" do
      it "returns the directory with the name given from the contents" do
        directory = Day07::Directory.new("a")
        inner_directory = Day07::Directory.new("b")
        directory.add(inner_directory)

        expect(directory.get_dir("b")).to eq(inner_directory)
      end

      it "returns nil if no directory is found" do
        directory = Day07::Directory.new("a")

        expect(directory.get_dir("b")).to be_nil
      end
    end
  end

  describe "Filesystem" do
    describe "#cd" do
      it "changes the cwd to the folder name given" do
        root_directory = Day07::Directory.new("/")
        inner_directory = Day07::Directory.new("a")
        root_directory.add(inner_directory)

        filesystem = Day07::Filesystem.new(root_directory)
        filesystem.cd("a")

        expect(filesystem.cwd).to eq(inner_directory)
      end

      it "changes the cwd to the parent folder when the path is .." do
        root_directory = Day07::Directory.new("/")
        inner_directory = Day07::Directory.new("a")
        root_directory.add(inner_directory)

        filesystem = Day07::Filesystem.new(root_directory, inner_directory)
        filesystem.cd("..")

        expect(filesystem.cwd).to eq(root_directory)
      end

      it "changes the cwd to the root folder when the path is /" do
        root_directory = Day07::Directory.new("/")
        inner_directory = Day07::Directory.new("a")
        root_directory.add(inner_directory)

        filesystem = Day07::Filesystem.new(root_directory, inner_directory)
        filesystem.cd("/")

        expect(filesystem.cwd).to eq(root_directory)
      end
    end
  end

  describe "#part_one" do
    it "Finds the sum of all directories with a size <= 100000" do
      input = File.readlines("spec/test_inputs/07.txt", chomp: true)
      expect(Day07.part_one(input)).to eq(95437)
    end
  end

  describe "#part_two" do
    it "Finds the size of the smallest directory needed to free up enough space" do
      input = File.readlines("spec/test_inputs/07.txt", chomp: true)
      expect(Day07.part_two(input)).to eq(24933642)
    end
  end
end
