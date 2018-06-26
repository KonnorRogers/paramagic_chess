module ParamagicChess
  class Bishop < Piece
    def initialize(pos: nil, side: nil)
      super
      @type = :bishop
    end

    def to_s
      return "\u2657" if @side == :white
      return "\u265d" if @side == :black
      'Side not set'
    end
  end
end
