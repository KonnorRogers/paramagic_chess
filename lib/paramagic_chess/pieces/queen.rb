module ParamagicChess
  class Queen < Piece
    def initialize(pos: nil, side: nil)
      super
      @type = :queen
    end

    def to_s
      return "\e[34m\u265b" if @side == :white
      return "\e[31m\u265b" if @side == :black

      'Side not set'
    end
  end
end