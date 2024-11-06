require "./lib/parser.rb"
require "./lib/utils.rb"
require "./lib/base.rb"

class Day2 < Base
  DAY = 2

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