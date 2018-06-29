module ParamagicChess
  class King < Piece

    def initialize(pos: nil, side: nil, moved: false)
      super
      @type = :king
    end

    def to_s
      king = "\u265a"
      return king.blue if @side == :blue
      return king.red if @side == :red
      'Side not set'
    end
  end
end