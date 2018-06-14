module ParamagicChess
  class Bishop < Piece
    def initialize(pos:)
      super
      @type = :bishop
    end
  end
end