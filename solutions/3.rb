require "./lib/parser.rb"
require "./lib/utils.rb"
require "./lib/base.rb"

class Day3 < Base
  DAY = 3

  def initialize(type = "example")
    @input = Parser.lines(DAY, type)
  end

  def one
    1
  end

  def two
    2
  end
end