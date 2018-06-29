module ParamagicChess
  class Bishop < Piece
    def initialize(pos: nil, side: nil)
      super
      @type = :bishop
    end

    def to_s
      return "\e[34m\u265d" if @side == :white
      return "\e[31m\u265d" if @side == :black
      'Side not set'
    end
  end
end
