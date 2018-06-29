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

    # creates an integer of the y value
    def y_coord(pos:)
      pos.to_s.split(/[a-z]/)[1].to_i
    end

    # creates a symbol for the first coord
    def x_coord(pos:)
      pos[0].to_sym
    end

    def move_to(pos:, board: Board.new)
      return "#{pos} is an invalid move. Try again." unless valid_move?(pos: pos)

      update_position(pos: pos)
      @moved = true if @moved == false
      board.board[pos].piece = self
      # Super method to be called, so as not to rewrite for every class
      # Update possible moves is up to the class
    end

    def moved?
      @moved
    end

    def valid_move?(pos:, board: Board.new)
      y = y_coord(pos: pos)
      return false unless CHAR_TO_NUM.key?(pos[0].to_sym)
      return false if y > Board::MAX_INDEX || y < Board::MIN_INDEX

      true
    end
  end
end
