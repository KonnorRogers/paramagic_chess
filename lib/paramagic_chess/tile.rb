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

    def contains_white_piece?
      return true if @piece.side == :white
      false
    end

    def contains_black_piece?
      return true if @piece.side == :black
      false
    end

    def to_s
      return "\e[47m   \e[0m" if @background == :white && @piece.nil?
      return "\e[40m   \e[0m" if @background == :black && @piece.nil?

      # sets black foreground on white background
      # return "\e[30;47m #{@piece} \e[0m" if @background == :white
      # sets white forground on black background
      # return "\e[37;40m #{@piece} \e[0m" if @background == :black

      return "\e[47m #{@piece} \e[0m" if @background == :white
      return "\e[40m #{@piece} \e[0m" if @background == :black

      return 'Background not set'
    end
  end
end
