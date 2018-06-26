module ParamagicChess
  class Rook < Piece
    def initialize(pos: nil, side: :nil)
      super
      @type = :rook
    end

    def to_s
      return "\u2656" if @side == :white
      return "\u265c" if @side == :black
      'Side not set'
    end
  end
end
