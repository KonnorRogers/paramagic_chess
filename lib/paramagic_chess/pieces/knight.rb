module ParamagicChess
  class Knight < Piece
    def initialize(pos: nil, side: nil, moved: false)
      super
      @type = :knight
    end

    def to_s
      knight = "\u265e"
      return knight.blue if @side == :blue
      return knight.red if @side == :red
      'Side not set'
    end
  end
end
