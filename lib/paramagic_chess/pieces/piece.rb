module ParamagicChess
  class Piece
    attr_accessor :x, :y, :pos, :type, :side

    def initialize(pos:, side: nil)
      check_position(pos)
      @x = pos[0]
      @y = pos[1]
      @pos = pos
      @side = side
    end
    
    def check_position(pos)
      raise ArgumentError, "first coordinate must be a - h" unless pos[0] =~ /[a-h]/
      raise ArgumentError, "second coordinate must be 1 - 8" unless pos[1] =~ /[1-8]/
      true
    end
  end
end
