module ParamagicChess
  class Rook < Piece
    def initialize(pos:)
      super
      @type = :rook
    end
  end
end