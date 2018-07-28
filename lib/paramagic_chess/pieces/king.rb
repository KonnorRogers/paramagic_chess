module ParamagicChess
  class King < Piece
    MOVE_SET = Box.new

    def initialize(pos: nil, side: nil, moved: false)
      super
      @type = :king
    end

    def to_s
      king = "\u265a"
      return king.blue if @side == :blue
      return king.red if @side == :red
      'Side not set'
    end
    
    def update_moves(board:)
      @possible_moves = []
      @possible_moves.concat(MOVE_SET.possible_moves(board: board, piece: self))
    end
    
    def move_to(board:, pos:)
      update_moves(board: board)
      unless @possible_moves.include? pos
        puts ":#{pos} is an invalid move. Try again."
        return nil
      end
      super if @possible_moves.include? pos
      true
    end
  end
end