require 'irb/color'

module TwoD
  class Smatrix
    attr_accessor :values

    def initialize(num_rows, num_columns, value: nil)
      @values = Array.new(num_rows) do
        Array.new(num_columns, (value.call rescue value))
      end
    end

    def [](x,y)
      @values[y][x]
    end

    def []=(x,y, c)
      raise "[x,y,c] outside bounds (#{[x,y,c]})" if !in_bounds?(x: x, y: x)
      @values[y][x] = c
    end

    def in_bounds? x: :ignore, y: :ignore
      x_okay = (x == :ignore) || x >= 0 && x < @values[0].length
      y_okay = (y == :ignore) || y >= 0 && y < @values.length
      
      return x_okay && y_okay
    end

    def print! highlight_proc: Proc.new{false}, highlight_proc2: Proc.new{false}
      fmt = "%-#{@values.flatten.map(&:to_s).map(&:chars).map(&:length).max+1}s"
      @values.each_with_index do |row,rowidx|
        row.each_with_index do |value,colidx|
          if highlight_proc2.call(colidx, rowidx, value)
            print IRB::Color::colorize(fmt % value.to_s, [:RED])
          elsif highlight_proc.call(colidx, rowidx, value)
            print IRB::Color::colorize(fmt % value.to_s, [:BLUE])
          else
            print fmt % value.to_s
          end
        end
        puts
      end
    end

    def rows
      @values.count
    end

    def cols
      @values[0].count
    end

    def each_neighbour4_pos(x_or_pos,y=nil)
      if x_or_pos.is_a? Array
        x = x_or_pos[0]
        y = x_or_pos[1]
      else
        x = x_or_pos
      end

      [[0,-1], [1,0], [0,1], [-1,0]].each do |dx, dy|
        next_x = x + dx
        next_y = y + dy
        yield next_x, next_y if in_bounds?(x: next_x, y: next_y)
      end
    end

    # yield x, y, value
    def each_neighbour4(x_or_pos,y=nil)
      if x_or_pos.is_a? Array
        x = x_or_pos[0]
        y = x_or_pos[1]
      else
        x = x_or_pos
      end

      [[0,-1], [1,0], [0,1], [-1,0]].each do |dx, dy|
        next_x = x + dx
        next_y = y + dy
        yield next_x, next_y, self[next_x, next_y] if in_bounds?(x: next_x, y: next_y)
      end
    end

    def each_neighbour8(x,y)
      raise
    end

    def each_neighbour9(x,y)
      raise
    end

    # yield x, y, value
    def each
      @values.each_with_index do |columns, rowidx|
        columns.each_with_index do |value, colidx|
          yield colidx,rowidx,value
        end
      end
    end

    def lower_right_pos
      [cols - 1, rows - 1]
    end

    def pos_lower_right
      [cols - 1, rows - 1]
    end
  end
end
