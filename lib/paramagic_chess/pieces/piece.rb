module ParamagicChess
  class Piece
    attr_accessor :x, :y, :pos, :type

    def initialize(pos:)
      @x = pos[0]
      @y = pos[1]
      @pos = pos
    end
  end
end
