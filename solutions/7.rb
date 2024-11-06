require "./lib/parser.rb"
require "./lib/utils.rb"
require "./lib/base.rb"

class Day7 < Base
  DAY = 7
  MAX = 2.pow(16)-1

  def initialize(type = "example")
    lines = Parser.lines(DAY, type)
    @operations = {}
    lines.each do |line|
      if line =~ /(\w+) (AND|OR) (\w+) -> (\w+)/
        @operations[$4] = [$2, $1, $3]
      elsif line =~ /(\w+) (LSHIFT|RSHIFT) (\d+) -> (\w+)/
        @operations[$4] = [$2, $1, $3.to_i]
      elsif line =~ /NOT (\w+) -> (\w+)/
        @operations[$2] = ["NOT", $1]
      elsif line =~ /(\w+) -> (\w+)/
        @operations[$2] = ["EQ", $1]
      end
    end
  end

  def calculate(map, var)
    return var.to_i if var == var.to_i.to_s
    return map[var] if map[var]

    op = @operations[var]

    case op[0]
    when "EQ"
      map[var] = calculate(map, op[1])
    when "AND"
      map[var] = calculate(map, op[1]) & calculate(map, op[2])
    when "OR"
      map[var] = calculate(map, op[1]) | calculate(map, op[2])
    when "LSHIFT"
      map[var] = calculate(map, op[1]) << op[2]
    when "RSHIFT"
      map[var] = calculate(map, op[1]) >> op[2]
    when "NOT"
      map[var] = MAX ^ calculate(map, op[1])
    end

    map[var]
  end

  def one
    @map_one = {}
    calculate(@map_one, "a")
  end

  def two
    @map_two = {}
    @map_two["b"] = @map_one["a"]
    calculate(@map_two, "a")
  end
end