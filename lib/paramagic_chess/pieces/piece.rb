module ParamagicChess
  class Piece
    attr_accessor :side, :possible_moves
    attr_reader :x, :y, :pos, :type, :moved

    def initialize(pos: nil, side: nil, moved: false)
      update_position(pos: pos)
      @side = side
      @moved = moved
      @possible_moves = []
    end

    # updates position, x & y values
    def update_position(pos:)
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

    def move_to(pos:, board: Board.new)
      return ":#{pos} is an invalid move. Try again." unless valid_move?(pos: pos)

      # sets initial spot to nil
      board.board[@pos].piece = nil
      update_position(pos: pos)
      @moved = true if @moved == false

      if board.board[pos].contains_piece?
        remove_piece(pos: pos, board: board)
      end

      board.board[pos].piece = self
      # Super method to be called, so as not to rewrite for every class
      # Update possible moves is up to the class
    end

    def remove_piece(pos:, board:)
      if board.board[pos].contains_red_piece?
        board.removed_red_pieces << board.board[pos].piece
      elsif board.board[pos].contains_blue_piece?
        board.removed_blue_pieces << board.board[pos].piece
      end
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
