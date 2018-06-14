module ParamagicChess
  class Knight < Piece
    def initialize(pos:)
      super
      @type = :knight
    end
  end
end