module ParamagicChess
  class Pawn < Piece
    def initialize(pos: nil, side: nil)
      super
      @type = :pawn
    end

    def to_s
      return "\e[34m\u265f" if @side == :white
      return "\e[31m\u265f" if @side == :black
      'Side not set'
    end

    def move_to(pos:)
      super
    end
  end
end