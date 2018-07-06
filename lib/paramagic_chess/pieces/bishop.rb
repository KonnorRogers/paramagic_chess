module ParamagicChess
  class Bishop < Piece
    def initialize(pos: nil, side: nil, moved: false)
      super
      @type = :bishop
    end

    def to_s
      bishop = "\u265d"
      return bishop.blue if @side == :blue
      return bishop.red if @side == :red
      'Side not set'
    end
    
    def move_to(pos:, board:)
      update_moves(board: board)
      super if @possible_moves.include? pos
      return "#{pos} is not a valid move."
    end
    
    def update_moves(board:)
      update_blue_moves(board: board) if @side == :blue
      update_red_moves(board: board) if @side == :red
    end
    
    private
    
    def update_blue_moves(board:)
      @possible_moves = []
    end
    
    def update_red_moves(board:)
      @possible_moves = []
    end
    
    def red_up_blue_down(board:)
      array = []
      1.upto(8) do |index|
        pos = to_pos(x: NUM_TO_CHAR[@x + index], y: @y + index)
        return array if blocked_by_team?(pos: pos, board: board)
        array << pos
        return array if blocked_by_enemy?(pos: pos, board: board)
      end
    end
    
    
    def blocked_by_team?(board:, pos:)
      return true if board.board[pos].contains_red_piece? && @side == :red
      return true if board.board[pos].contains_blue_piece? && @side == :blue
      false
    end
    
    def blocked_by_enemy?(board:, pos:)
      return true if board.board[pos].contains_red_piece? && @side == :blue
      return true if board.board[pos].contains_blue_piece? && @side == :red
      false
    end
  end
end
