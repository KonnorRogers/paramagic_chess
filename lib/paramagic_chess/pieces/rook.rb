module ParamagicChess
  class Rook < Piece
    def initialize(pos: nil, side: :nil)
      super
      @type = :rook
    end

    def to_s
      return "\e[34m\u265c" if @side == :white
      return "\e[31m\u265c" if @side == :black
      'Side not set'
    end
  end
end
