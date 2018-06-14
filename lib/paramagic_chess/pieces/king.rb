module ParamagicChess
  class King < Piece
    
    def initialize(pos:, side: nil)
      super
      @type = :king
    end
    
    def to_s
      return "\u2654" if @side == :white
      return "\u265a" if @side == :black
      'Side not set'
    end
  end
end