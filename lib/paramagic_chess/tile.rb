module ParamagicChess
  class Tile
    attr_accessor :background, :piece

    def initialize(piece: nil, background: nil)
      @piece = piece
      @background = background
    end

    def contains_piece?
      return false if @piece.nil?
      true
    end
  end
end
