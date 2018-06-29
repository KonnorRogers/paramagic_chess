module ParamagicChess
  class Pawn < Piece
    def initialize(pos: nil, side: nil)
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
      
      # red pawns can only move -1 on the y axis
      @possible_moves << to_pos(x: @x, y: @y - 1)
      @possible_moves << to_pos(x: @x, y: @y - 2) if moved? == false
      
      # checks if any enemy blue pieces at the diagonals
      possible_diagonals = blue_diagonals(board: board)
      @possible_moves << possible_diagonals unless blue_diagonals.empty?
    end
    
    def blue_diagonals(board: Board.new)
      x_num = CHAR_TO_NUM[@x]
      
      possible_diagonals = []
      possible_diagonals << to_pos(x: NUM_TO_CHAR[x_num + 1],
                                  y: @y - 1)
      possible_diagonals << to_pos(x: NUM_TO_CHAR[x_num - 1 ],
                                  y: @y - 1)
      
      possible_diagonals.select do |pos| 
        next if board.board[pos].nil?
        board.board[pos].contains_blue_piece?
      end
    end

    def move_to(pos:, board: Board.new)
      super
      
      
    end
  end
end