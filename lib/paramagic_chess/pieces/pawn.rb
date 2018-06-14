module ParamagicChess
  class Pawn < Piece
    def initialize(pos:, side: nil)
      super
      @type = :pawn
    end
    
    def to_s
      return "\u2659" if @side == :white
      return "\u265f" if @side == :black
      'Side not set'
    end
  end
end