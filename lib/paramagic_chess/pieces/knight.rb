module ParamagicChess
  class Knight < Piece
    def initialize(pos: nil, side: nil)
      super
      @type = :knight
    end

    def to_s
      return "\u2658" if @side == :white
      return "\u265e" if @side == :black
      'Side not set'
    end
  end
end
