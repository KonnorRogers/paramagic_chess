module ParamagicChess
  class Knight < Piece
    def initialize(pos: nil, side: nil)
      super
      @type = :knight
    end

    def to_s
      return "\e[34m\u265e" if @side == :white
      return "\e[31m\u265e" if @side == :black
      'Side not set'
    end
  end
end
