module ParamagicChess
  class Piece
    attr_accessor :side, :possible_moves
    attr_reader :x, :y, :pos, :type, :moved

    def initialize(pos:, side: nil, moved: false)
      check_position(pos)
      @x = pos[0]
      @y = pos[1]
      @pos = pos
      @side = side
      @moved = moved
      @possible_moves = {}
    end

    def check_position(pos)
      raise ArgumentError, "first coordinate must be a - h" unless pos[0] =~ /[a-h]/
      raise ArgumentError, "second coordinate must be 1 - 8" unless pos[1] =~ /[1-8]/
      true
    end

    def moved?
      @moved
    end
  end
end
