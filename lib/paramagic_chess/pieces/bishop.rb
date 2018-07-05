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

    def red
      return :red if @side == :red
    end

    def blue
      return :blue if @side == :blue
    end
  end
end
