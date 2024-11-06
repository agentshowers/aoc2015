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

  def merge(sets, a, b, state)
    if sets.length > 0 && sets.last[2] == state
      sets.last[1] = b
    else
      sets << [a, b, state]
    end
  end

  def toggle_lights
    lights = Array.new(1000) { [[0, 999, 0]] }
    @input.each do |action, x1, y1, x2, y2|
      (x1..x2).to_a.each do |x|
        new_sets = []
        lights[x].each do |a, b, state|
          if b < y1 || a > y2
            merge(new_sets, a, b, state)
            next
          end

          merge(new_sets, a, y1 - 1, state) if a < y1

          left = [a, y1].max
          right = [b, y2].min
          new_state = yield(action, state)
          merge(new_sets, left, right, new_state)

          merge(new_sets, y2 + 1, b, state) if b > y2
        end

        lights[x] = new_sets
      end
    end

    lights.sum do |line|
      line.sum do |a, b, state|
        state * (b - a + 1)
      end
    end
  end

  def one
    toggle_lights do |action, state|
      case action
      when "on"
        1
      when "off"
        0
      else
        1 - state
      end
    end
  end

  def two
    toggle_lights do |action, state|
      case action
      when "on"
        state + 1
      when "off"
        [0, state - 1].max
      else
        state + 2
      end
    end
  end
end