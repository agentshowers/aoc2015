require "./lib/parser.rb"
require "./lib/utils.rb"
require "./lib/base.rb"

class Day5 < Base
  DAY = 5

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