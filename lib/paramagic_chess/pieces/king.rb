module ParamagicChess
  class King < Piece

    def initialize(pos:, side: nil)
      super
      @type = :king
    end

    def to_s
      king = "\u265a"
      return king.blue if @side == :white
      return king.red if @side == :black
      'Side not set'
    end
  end
end