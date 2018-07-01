module ParamagicChess
  class Pawn < Piece
    def initialize(pos: nil, side: nil, moved: false)
      super
      @type = :pawn
      @double_move = false
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
      start_position = @pos
      update_moves(board: board)
      unless @possible_moves.include? pos
        return ":#{pos} is an invalid move. Try again."
      end

      
      super

      if @side == :red
        @double_move = red_moved_twice?(start: start_position, end_pos: pos)
      else
        @double_move = blue_moved_twice?(start: start_position, end_pos: pos)
      end
    end

    def double_move?
      @double_move
    end

    private

    # works
    def horizontal_pawns(board:)
      positions_with_pawn = []
      x = CHAR_TO_NUM[@x]

      pos1 = to_pos(x: NUM_TO_CHAR[x - 1], y: @y)
      pos2 = to_pos(x: NUM_TO_CHAR[x + 1], y: @y)

      positions_with_pawn << pos1 if !board.board[pos1].nil? && board.board[pos1].piece_type == :pawn
      positions_with_pawn << pos2 if !board.board[pos2].nil? && board.board[pos2].piece_type == :pawn

      # p positions_with_pawn
      positions_with_pawn
    end
    
    # needs work
    def blue_en_passant(board:)
      horizontal_pawns = horizontal_pawns(board: board)
      return nil if horizontal_pawns.empty?
      
      horizontal_pawns.select! do |pos|
        board.board[pos].piece.double_move? && board.board[pos].piece.side == :red
      end
      
      horizontal_pawns
    end

    # needs work
    def red_en_passant(board:)
      horizontal_pawns = horizontal_pawns(board: board)
      return nil if horizontal_pawns.empty?
      
      horizontal_pawns.select! do |pos|
        board.board[pos].piece.double_move? && board.board[pos].piece.side == :blue
      end
      
      horizontal_pawns
    end

    def red_moved_twice?(start:, end_pos:)
      return true if y_coord(pos: start) == y_coord(pos: end_pos) + 2
      false
    end
    
    def blue_moved_twice?(start:, end_pos:)
      return true if y_coord(pos: start) == y_coord(pos: end_pos) - 2
      false
    end

    def update_blue_moves(board:)
      # reset possible moves
      @possible_moves = []

      pos1 = to_pos(x: @x, y: @y + 1)
      pos2 = to_pos(x: @x, y: @y + 2)

      # red pawns can only move -1 on the y axis
      @possible_moves << pos1 unless board.board[pos1].contains_piece?

      if positions_not_blocked?(pos1: pos1, pos2: pos2, board: board)
        @possible_moves << pos2 if @moved == false
      end

      blue_diagonals(board: board)
    end

    def update_red_moves(board:)
      # reset possible moves
      @possible_moves = []

      pos1 = to_pos(x: @x, y: @y - 1)
      pos2 = to_pos(x: @x, y: @y - 2)

      # red pawns can only move -1 on the y axis
      @possible_moves << pos1 unless board.board[pos1].contains_piece?

      if positions_not_blocked?(pos1: pos1, pos2: pos2, board: board)
        @possible_moves << pos2 if @moved == false
      end

      red_diagonals(board: board)
    end

    def blue_diagonals(board:)
      x = CHAR_TO_NUM[@x]
      en_passant = blue_en_passant(board: board)

      p en_passant
      possible_diagonals = []
      diagonal1 = to_pos(x: NUM_TO_CHAR[x + 1], y: @y + 1)
      diagonal2 = to_pos(x: NUM_TO_CHAR[x - 1], y: @y + 1)

      possible_diagonals << diagonal1
      possible_diagonals << diagonal2
      
      possible_diagonals.each do |pos|
        next if board.board[pos].nil?
        @possible_moves << pos if board.board[pos].contains_red_piece?

        next if en_passant.nil?
        next if en_passant[0].nil?
        if y_coord(pos: en_passant[0]) == y_coord(pos: pos) - 1
          @possible_moves << pos if x_coord(pos: en_passant[0]) == x_coord(pos: pos)
        end

        next if en_passant[1].nil?
        if y_coord(pos: en_passant[1]) == y_coord(pos: pos) - 1
          @possible_moves << pos if x_coord(pos: en_passant[1]) == x_coord(pos: pos)
        end
      end
    end

    def red_diagonals(board:)
      x = CHAR_TO_NUM[@x]
      en_passant = red_en_passant(board: board)

      possible_diagonals = []
      diagonal1 = to_pos(x: NUM_TO_CHAR[x + 1], y: @y - 1)
      diagonal2 = to_pos(x: NUM_TO_CHAR[x - 1], y: @y - 1)

      possible_diagonals << diagonal1
      possible_diagonals << diagonal2

      possible_diagonals.each do |pos|
        next if board.board[pos].nil?
        @possible_moves << pos if board.board[pos].contains_blue_piece?

        next if en_passant.nil?
        next if en_passant[0].nil?
        if y_coord(pos: en_passant[0]) == y_coord(pos: pos) + 1
          @possible_moves << pos if x_coord(pos: en_passant[0]) == x_coord(pos: pos)
        end

        next if en_passant[1].nil?
        if y_coord(pos: en_passant[1]) == y_coord(pos: pos) + 1
          @possible_moves << pos if x_coord(pos: en_passant[1]) == x_coord(pos: pos)
        end
      end
    end

    def positions_not_blocked?(pos1:, pos2:, board:)
      return false if board.board[pos1].contains_piece?
      return false if board.board[pos2].contains_piece?
      true
    end
  end
end
