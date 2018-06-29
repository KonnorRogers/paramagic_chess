module ParamagicChess
  class King < Piece

    def initialize(pos:, side: nil)
      super
      @type = :king
    end

    def to_s
      return "\e[34m\u265a" if @side == :white
      return "\e[31m\u265a" if @side == :black
      'Side not set'
    end
  end
end