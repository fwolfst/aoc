#!/usr/bin/env ruby

require 'matrix'

# Puzzle 46: https://adventofcode.com/2020/day/23#part2
# Felix Wolfsteller

$DEBUG = false

def dputs string
  puts string if $DEBUG
end

if ARGV.delete '-d'
  $DEBUG = true
  dputs "enabled debugging output"
end

class NilNode
  def self.debug_puts
    puts "NILNODE"
  end
  def self.obj
    nil
  end
end

class Node
  attr_accessor :obj, :next_node
  def initialize obj, next_node
    @obj = obj
    @next_node = next_node
  end

  def nexth_node n
    node = self
    n.times do |_n|
      node = node.nexth_node
    end
    node
  end

  def debug_puts n=5, obj_only=false
    node = self
    n_next_nodes = n.times.map do |_n|
      node = node.next_node
      node
    end
    if obj_only
      puts [self, *n_next_nodes].map{|n| n == self ? "(#{n.obj})" : n.obj}.join " "
    else
      puts [self, *n_next_nodes].map{|n| "{#{n.obj.to_s}} [#{n==self ? '*' : ''}#{n.object_id}]"}.join" -> "
    end
  end

  def cut_next_three
    node = self
    old_next = @next_node
    3.times do |_n|
      node = node.next_node
    end
    @next_node = node.next_node
    node.next_node = NilNode
    old_next
  end

  def insert_after chain
    old_next = @next_node
    @next_node = chain
    last = chain
    while last.next_node != NilNode
      last = last.next_node
    end
    last.next_node = old_next
  end

  def to_s
    super + "[obj: #{@obj.to_s}]->next_node:#{@next_node.obj.to_s}"
  end
end

class WrappedLinkedList
  # Actually there is no head or tail, its a ring!
  attr_accessor :head, :tail, :size, :obj_map

  def initialize first_element
    @head = Node.new(first_element,nil)
    @head.next_node = @head
    @obj_map = {first_element => @head}
    @tail = @head
    @size = 1
  end

  def at index
    cursor = @head
    (index % @size).times do |_idx|
      puts "At #{index} #{cursor.obj}"
      cursor = cursor.next_node
    end
    cursor.obj
  end

  def index_of element
    cursor = @head
    index = 0
    while cursor.obj != element && index < @size
      cursor = cursor.next_node
      index+= 1
    end
    index
  end

  def next_3 index
    cursor = node_at index
    3.times.map do |n|
      obj = cursor.next_node.obj
      cursor = cursor.next_node
      obj
    end
  end

  def take_out_3 index
    # niy
  end

  def <<(element)
    @size+= 1
    new_node = Node.new(element, @head)
    @obj_map[element] = new_node
    @tail.next_node = new_node
    @tail = new_node
  end

  def node_at index
    idx = 0
    cursor = @head
    while idx != index
      cursor = cursor.next_node
      idx+= 1
    end
    cursor
  end

  def node_for obj
    @obj_map[obj]
  end
end

input = '952316487'.chars.map(&:to_i)
#input = '389125467'.chars.map(&:to_i)
$list = WrappedLinkedList.new input.shift

input.each do |i|
  $list << i
end

(1000000 - 9).times do |n|
  $list << (10 + n)
end

$list.head.debug_puts(4)

def make_turn current_cup_node
  #print "cups: "
  #current_cup_node.debug_puts 11, true

  picked_up = current_cup_node.cut_next_three
  picked_up_vals = [picked_up.obj, picked_up.next_node.obj, picked_up.next_node.next_node.obj]

  dputs "pick up: " + picked_up_vals.join(', ')

  destination = current_cup_node.obj - 1
  if destination < 1
    destination = $list.size
  end
  while picked_up_vals.include? destination
    destination-= 1
    if destination < 1
      destination = $list.size
    end
  end

  destination_node = $list.node_for destination

  dputs destination_node.obj

  destination_node.insert_after picked_up

  clockwise_of_current = current_cup_node.next_node

  return clockwise_of_current
end

turn_limit = 10000000

current_cup_node = $list.head

turn_limit.times do |move|
  dputs "-- move #{move + 1} --"
  current_cup_node = make_turn current_cup_node
  dputs ""
  if move % 10000 == 0
    puts move
  end
end

#puts "-- final --"
#print "cups: "
#current_cup_node.debug_puts 11, true

current_cup_node.debug_puts 3, true

($list.node_for 1).debug_puts 3

one_node = $list.node_for 1
puts "Result: #{one_node.next_node.obj * one_node.next_node.next_node.obj}"

exit 0
