require "./lib/parser.rb"
require "./lib/utils.rb"
require "./lib/base.rb"

class Day6 < Base
  DAY = 6

  def initialize(type = "example")
    lines = Parser.lines(DAY, type)
    regex = /^(turn (on|off)|toggle) (\d+),(\d+) through (\d+),(\d+)$/i

    @input = lines.map do |line|
      match = line.match(regex)
      action = match[2] || match[1]
      x1, y1 = match[3].to_i, match[4].to_i # Origin coordinates
      x2, y2 = match[5].to_i, match[6].to_i # Destination coordinates

      [action, x1, y1, x2, y2]
    end
  end

  def one
    lights = Array.new(1000) { Array.new(1000) { false } }
    @input.each do |action, x1, y1, x2, y2|
      (x1..x2).to_a.each do |x|
        (y1..y2).to_a.each do |y|
          case action
          when "on"
            lights[x][y] = true
          when "off"
            lights[x][y] = false
          else
            lights[x][y] = !lights[x][y]
          end
        end
      end
    end

    lights.sum do |line|
      line.count { |x| x }
    end
  end

  def two
    lights = Array.new(1000) { Array.new(1000) { 0 } }
    @input.each do |action, x1, y1, x2, y2|
      (x1..x2).to_a.each do |x|
        (y1..y2).to_a.each do |y|
          case action
          when "on"
            lights[x][y] += 1
          when "off"
            lights[x][y] -= 1 if lights[x][y] > 0
          else
            lights[x][y] += 2
          end
        end
      end
    end

    lights.sum do |line|
      line.sum
    end
  end
end