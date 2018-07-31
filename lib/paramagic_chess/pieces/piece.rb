require_relative "../moves.rb"

module ParamagicChess
  class Piece
    include Moves
    attr_accessor :side, :possible_moves, :type
    attr_reader :x, :y, :pos, :moved, :_test

    def initialize(pos: nil, side: nil, moved: false, _test: false)
      update_position(pos: pos)
      @side = side
      @moved = moved
      @possible_moves = []
      @starting_pos = pos
      @_test = _test
    end

    # updates position, x & y values
    def update_position(pos:)
      return nil if pos.nil?
      @x = pos[0].to_sym
      @y = y_coord(pos: pos)
      @pos = pos
    end

    def to_pos(x:, y:)
      (x.to_s + y.to_s).to_sym
    end

    # creates an integer of the y value
    def y_coord(pos:)
      pos.to_s.split(/[a-z]/)[1].to_i
    end

    # creates a symbol for the first coord
    def x_coord(pos:)
      pos[0].to_sym
    end

    def move_to(pos:, board: Board.new, input: nil)
      unless valid_move?(pos: pos)
        puts ":#{pos} is an invalid move. Try again." 
        return nil
      end
      start_pos = @pos
      
      # sets initial spot to nil
      board.board[@pos].piece = nil
      update_position(pos: pos)
      
      # keep a log of the removed piece to check if that side will now be in check
      removed = remove_piece(pos: pos, board: board)
      board.board[pos].piece = self
      
      # checks if it puts you in check
      king = board.find_king(side: @side)
      if @_test == false && king.check?(board: board)
        reset_to_previous_state(board: board, removed: removed, start_pos: start_pos, moving_pos: pos)
        puts "That will put your king in check!"
        return nil
      end
      # Super method to be called, so as not to rewrite for every class
      # Update possible moves is up to the class
      @moved = true if @moved == false
      true
    end
    
    def reset_to_previous_state(board:, removed:, start_pos:, moving_pos:)
      # handles removed pieces
      # must check to see that a piece was removed
      if removed.nil?
        board.board[moving_pos].piece = nil
      else
        board.board[removed.pos].piece = removed
        board.removed_red_pieces.pop if removed.side == :red
        board.removed_blue_pieces.pop if removed.side == :blue
      end
      
      update_position(pos: start_pos)
      board.board[start_pos].piece = self
    end

    def remove_piece(pos:, board:)
      removed_piece = nil
      if board.board[pos].contains_red_piece? && @side == :blue
        board.removed_red_pieces << board.board[pos].piece
        removed_piece = board.board[pos].piece
      elsif board.board[pos].contains_blue_piece? && @side == :red
        board.removed_blue_pieces << board.board[pos].piece
        removed_piece = board.board[pos].piece
      end
      
      board.board[pos].piece = nil
      removed_piece
    end
    
    def opposite_side(side:)
      return :blue if side == :red
      return :red if side == :blue
      nil
    end

    def moved?
      @moved
    end

    def valid_move?(pos:, board: Board.new)
      y = y_coord(pos: pos)
      # Checks if the x coord is in the char_to_num index
      return false unless CHAR_TO_NUM.key?(pos[0].to_sym)
      return false if y > Board::MAX_INDEX || y < Board::MIN_INDEX

      true
    end
  end
end
