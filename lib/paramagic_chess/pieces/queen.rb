module ParamagicChess
  class Queen < Piece
    def initialize(pos:)
      super
      @type = :queen
    end
  end
end