module ParamagicChess
  class Pawn < Piece
    def initialize(pos: nil, side: nil)
      super
      @type = :pawn
    end

    def to_s
      pawn = "\u265f"
      return pawn.blue if @side == :blue
      return pawn.red if @side == :red
      'Side not set'
    end

    def move_to(pos:)
      super
    end
  end
end