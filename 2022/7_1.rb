#!/usr/bin/env ruby

# Felix Wolfsteller
# https://adventofcode.com/2022/day/6

#input = DATA.readlines.map &:strip#ARGF.readlines.map &:strip
input = ARGF.readlines.map &:strip

puts "---"

Directory = Struct.new('Directory', :name, :size, :content, :parent) do
  def size_recursive
    content.inject(size) {|total_size, subdir| total_size += subdir.size_recursive}
  end

  def create_subdir name=nil
    (content << self.class.new(name,0,[],self)).last
  end
end

# root baby
$root = Directory.new('/',0,[],nil)
$cwd = $root

def handle_cmd(line)
  if line == '$ cd /'
    $cwd == $root
  elsif line == '$ cd ..'
    $cwd = $cwd.parent
  elsif line.start_with? '$ cd'
    $cwd = $cwd.create_subdir line[4..-1]
  else
    # ls
  end
end

input.each do |line|
  if line.start_with? '$'
    handle_cmd(line)
  else
    $cwd.size += line.split.first.to_i
  end
end

p $cwd

p ObjectSpace.each_object(Directory).to_a.select{_1.size_recursive <= 100_000}.map { _1.name + ": #{_1.size}" }
p ObjectSpace.each_object(Directory).to_a.select{_1.size_recursive <= 100_000}.sum(&:size_recursive)


__END__
$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k
