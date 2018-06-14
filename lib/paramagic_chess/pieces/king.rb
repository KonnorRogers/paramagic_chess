module ParamagicChess
  class King < Piece
    
    def initialize(pos:)
      super
      @type = :king
    end
  end
end