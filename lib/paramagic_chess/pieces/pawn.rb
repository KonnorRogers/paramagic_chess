# frozen_string_literal: true

module ParamagicChess
  class Pawn < Piece
    attr_accessor :double_move

    def initialize(pos: nil, side: nil, moved: false)
      super
      @type = :pawn
      @double_move = nil
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

    def move_to(pos:, board: Board.new, input: nil)
      update_moves(board: board)
      unless @possible_moves.include? pos
        puts ":#{pos} is an invalid move. Try again.".highlight
        return nil
      end

      puts 'test 1'
      do_en_passant(board: board, pos: pos)
      puts 'test 2'
      good_move = super
      return nil if good_move.nil?

      puts 'test 3'
      promote_to(pos: pos, input: input, board: board) if elgible_for_promotion?
      puts 'test 4'
      true
    end

    def double_move?
      @double_move
    end

    def do_en_passant(pos:, board:)
      red = red_en_passant(board: board) if @side == :red
      blue = blue_en_passant(board: board) if @side == :blue

      if @side == :red && red
        # pos plus 1
        pp_one = to_pos(x: x_coord(pos: pos), y: (y_coord(pos: pos) + 1))

        if !board.board[pp_one].piece.nil? && board.board[pp_one].piece.type == :pawn
          if board.board[pp_one].piece.double_move == true
            remove_piece(pos: pp_one, board: board) if board.board[pp_one].piece.double_move == true
          end
        end
      elsif @side == :blue && blue
        # pos minus 1
        pm_one = to_pos(x: x_coord(pos: pos), y: (y_coord(pos: pos) - 1))
        if !board.board[pm_one].piece.nil? && board.board[pm_one].piece.type == :pawn
          if board.board[pm_one].piece.double_move == true
            remove_piece(pos: pm_one, board: board)
          end
        end
      end

      @double_move = red_moved_twice?(start: @starting_pos, end_pos: pos) if @side == :red
      @double_move = blue_moved_twice?(start: @starting_pos, end_pos: pos) if @side == :blue
    end

    private

    def elgible_for_promotion?
      return true if @side == :red && @y == 1
      return true if @side == :blue && @y == 8

      false
    end

    def promote_to(pos:, board:, input:)
      if input.nil?
        puts 'What would you like to promote your pawn to?'.highlight
        puts PROMOTION_LIST.keys
        loop do
          input = gets.chomp.downcase.to_sym
          break if PROMOTION_LIST.key?(input)

          puts "#{input} is not a possible promotion. Try again".highlight
        end
      end

      promotion_piece = PROMOTION_LIST[input]
      promotion_piece.update_position(pos: pos)
      promotion_piece.side = @side

      board.board[pos].piece = promotion_piece
    end

    def horizontal_pawns(board:)
      positions_with_pawn = []
      x = CHAR_TO_NUM[@x]

      pos1 = to_pos(x: NUM_TO_CHAR[x - 1], y: @y)
      pos2 = to_pos(x: NUM_TO_CHAR[x + 1], y: @y)

      positions_with_pawn << pos1 if !board.board[pos1].nil? && board.board[pos1].piece_type == :pawn
      positions_with_pawn << pos2 if !board.board[pos2].nil? && board.board[pos2].piece_type == :pawn

      positions_with_pawn
    end

    def blue_en_passant(board:)
      horizontal_pawns = horizontal_pawns(board: board)
      return nil if horizontal_pawns.empty?

      horizontal_pawns.select! do |pos|
        board.board[pos].piece.double_move? && board.board[pos].piece.side == :red
      end
      # p horizontal_pawns
      horizontal_pawns
    end

    def red_en_passant(board:)
      horizontal_pawns = horizontal_pawns(board: board)
      return nil if horizontal_pawns.empty?

      horizontal_pawns.select! do |pos|
        board.board[pos].piece.double_move? && board.board[pos].piece.side == :blue
      end

      # p horizontal_pawns
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

        # puts en_passant[0].double_move?
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
      return false if board.board[pos2].nil? || board.board[pos2].contains_piece?

      true
    end
  end
end
