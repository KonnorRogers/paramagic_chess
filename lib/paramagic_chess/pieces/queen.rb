module ParamagicChess
  class Queen < Piece
    def initialize(pos: nil, side: nil, moved: false)
      super
      @type = :queen
    end

    def to_s
      queen = "\u265b"
      return queen.blue if @side == :blue
      return queen.red if @side == :red

      'Side not set'
    end
  end
end