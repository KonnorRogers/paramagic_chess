module ParamagicChess
  class Tile
    attr_accessor :background, :piece, :position

    def initialize(piece: nil, background: nil, position:)
      @piece = piece
      @background = background
      @position = position
    end

    def contains_piece?
      return false if @piece.nil?
      true
    end

    def to_s
      return "\u25fc" if @background == :white && @piece.nil?
      return "\u25fb" if @background == :black && @piece.nil?
    end
  end
end
