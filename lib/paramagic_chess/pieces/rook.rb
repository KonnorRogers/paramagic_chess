module ParamagicChess
  class Rook < Piece
    def initialize(pos: nil, side: :nil)
      super
      @type = :rook
    end

    def to_s
      rook = "\u265c"
      return rook.blue if @side == :blue
      return rook.red if @side == :red
      'Side not set'
    end
  end
end
