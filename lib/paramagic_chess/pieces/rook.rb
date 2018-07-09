module ParamagicChess
  class Rook < Piece
    MOVE_SET = Moves::Straight.new
    
    def initialize(pos: nil, side: :nil, moved: false)
      super
      @type = :rook
    end

    def to_s
      rook = "\u265c"
      return rook.blue if @side == :blue
      return rook.red if @side == :red
      'Side not set'
    end
    
    def update_moves(board:)
      @possible_moves = []
      @possible_moves.concat(MOVE_SET.possible_moves(board: board, piece: self))
    end
    
    def move_to(pos:, board:)
      update_moves(board: board)
      return ":#{pos} is an invalid move. Try again." unless @possible_moves.include? pos
      super if @possible_moves.include? pos
    end
  end
end
