module ParamagicChess
  class Rook < Piece
    def initialize(pos: nil, side: :nil)
      super
      @type = :rook
    end

    def to_s
      rook = "\u265c"
      return rook.blue if @side == :white
      return rook.red if @side == :black
      'Side not set'
    end
  end
end
