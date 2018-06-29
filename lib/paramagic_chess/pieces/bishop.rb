module ParamagicChess
  class Bishop < Piece
    def initialize(pos: nil, side: nil)
      super
      @type = :bishop
    end

    def to_s
      bishop = "\u265d"
      return bishop.blue if @side == :white
      return bishop.red if @side == :black
      'Side not set'
    end
  end
end
