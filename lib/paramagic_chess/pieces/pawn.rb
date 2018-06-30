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

    def update_red_moves(board: Board.new)
      # reset possible moves
      @possible_moves = []

      pos1 = to_pos(x: @x, y: @y - 1)
      pos2 = to_pos(x: @x, y: @y - 2)

      # red pawns can only move -1 on the y axis
      @possible_moves << pos1 unless board.board[pos1].contains_piece?
      @possible_moves << pos2 unless moved? == true || board.board[pos1].contains_piece?

      # checks if any enemy blue pieces at the diagonals
      possible_diagonals = blue_diagonals(board: board)

      # #concat used to avoid array of array
      @possible_moves.concat(possible_diagonals) unless possible_diagonals.empty?
    end

    def blue_diagonals(board: Board.new)
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

    def move_to(pos:, board: Board.new)
      update_red_moves(board: board)
      unless @possible_moves.include? pos
        return ":#{pos} is an invalid move. Try again."
      end

      super
    end
  end
end
