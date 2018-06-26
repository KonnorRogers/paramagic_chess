module ParamagicChess
  class Queen < Piece
    def initialize(pos: nil, side: nil)
      super
      @type = :queen
    end
    
    def to_s
      return "\u2655" if @side == :white
      return "\u265b" if @side == :black
      
      'Side not set'
    end
  end
end