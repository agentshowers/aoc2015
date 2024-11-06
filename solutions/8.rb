require "./lib/parser.rb"
require "./lib/utils.rb"
require "./lib/base.rb"

class Day8 < Base
  DAY = 8

  def initialize(type = "example")
    @input = Parser.lines(DAY, type)
  end

  def one
    @input.sum do |line|
      count = 2
      i = 1
      while i < line.length - 1 do
        if line[i] == "\\"
          jump = (line[i+1] == "x" ? 4 : 2)
        else
          jump = 1
        end
        i += jump
        count += (jump - 1)
      end
      count
    end
  end

  def two
    @input.sum do |line|
      2 + line.count("\"") + line.count("\\")
    end
  end
end