module ParamagicChess
  class Pawn < Piece
    def initialize(pos: nil, side: nil, moved: false)
      super
      @type = :pawn
    end

    def to_s
      # returns the unicode character shaded in the color
      pawn = "\u265f"
      return pawn.blue if @side == :blue
      return pawn.red if @side == :red
      'Side not set'
    end

    def update_moves(board:)
      update_red_moves(board: board) if @side == :red
      update_blue_moves(board: board) if @side == :blue
    end

    def move_to(pos:, board: Board.new)
      update_moves(board: board)
      unless @possible_moves.include? pos
        return ":#{pos} is an invalid move. Try again."
      end

      super
    end

    private

    def update_blue_moves(board:)
      # reset possible moves
      @possible_moves = []

      pos1 = to_pos(x: @x, y: @y + 1)
      pos2 = to_pos(x: @x, y: @y + 2)

      # red pawns can only move -1 on the y axis
      @possible_moves << pos1 unless board.board[pos1].contains_piece?

      if positions_not_blocked?(pos1: pos1, pos2: pos2, board: board)
        @possible_moves << pos2 if moved? == false
      end

      # checks if any enemy blue pieces at the diagonals
      possible_diagonals = blue_diagonals(board: board)

      # #concat used to avoid array of array
      @possible_moves.concat(possible_diagonals) unless possible_diagonals.empty?
  end

    def update_red_moves(board:)
      # reset possible moves
      @possible_moves = []

      pos1 = to_pos(x: @x, y: @y - 1)
      pos2 = to_pos(x: @x, y: @y - 2)

      # red pawns can only move -1 on the y axis
      @possible_moves << pos1 unless board.board[pos1].contains_piece?

      if positions_not_blocked?(pos1: pos1, pos2: pos2, board: board)
        @possible_moves << pos2 if moved? == false
      end

      # checks if any enemy blue pieces at the diagonals
      possible_diagonals = red_diagonals(board: board)

      # #concat used to avoid array of array
      @possible_moves.concat(possible_diagonals) unless possible_diagonals.empty?
    end

    def blue_diagonals(board:)
      x = CHAR_TO_NUM[@x]

      possible_diagonals = []
      possible_diagonals << to_pos(x: NUM_TO_CHAR[x + 1],
                                   y: @y + 1)
      possible_diagonals << to_pos(x: NUM_TO_CHAR[x - 1],
                                   y: @y + 1)
      possible_diagonals.select do |pos|
        # covers possible no method error case due to nil class
        next if board.board[pos].nil?
        board.board[pos].contains_red_piece?
      end
    end

    def red_diagonals(board:)
      x = CHAR_TO_NUM[@x]

      possible_diagonals = []
      possible_diagonals << to_pos(x: NUM_TO_CHAR[x + 1],
                                   y: @y - 1)
      possible_diagonals << to_pos(x: NUM_TO_CHAR[x - 1],
                                   y: @y - 1)
      possible_diagonals.select do |pos|
        # covers possible no method error case due to nil class
        next if board.board[pos].nil?
        board.board[pos].contains_blue_piece?
      end
    end

    def positions_not_blocked?(pos1:, pos2:, board:)
      return false if board.board[pos1].contains_piece?
      return false if board.board[pos2].contains_piece?
      true
    end
  end
end
