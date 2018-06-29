module ParamagicChess
  class Queen < Piece
    def initialize(pos: nil, side: nil)
      super
      @type = :queen
    end

    def to_s
      queen = "\u265b"
      return queen.blue if @side == :white
      return queen.red if @side == :black

      'Side not set'
    end
  end
end