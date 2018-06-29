module ParamagicChess
  class Bishop < Piece
    def initialize(pos: nil, side: nil, moved: false)
      super
      @type = :bishop
    end

    def to_s
      bishop = "\u265d"
      return bishop.blue if @side == :blue
      return bishop.red if @side == :red
      'Side not set'
    end
  end
end
