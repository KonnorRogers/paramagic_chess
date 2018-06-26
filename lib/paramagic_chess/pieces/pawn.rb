module ParamagicChess
  class Pawn < Piece
    def initialize(pos: nil, side: nil)
      super
      @type = :pawn
    end

    def to_s
      return "\u2659" if @side == :white
      return "\u265f" if @side == :black
      'Side not set'
    end
    
    def move_to(pos:)
      return 'Not a legal move. Please enter another coordinate.' unless @possible_moves.include?(pos)
      
      super
    end
    
    def black_diagonal_moves(board: Board.new)
      array = []
      x = @x.to_num
      
      array << to_symbol((x + 1)).to_s + y.coord - 1
      array << to_symbol((x - 1)).to_s + y.coord - 1
      
      array.select do |coord|
        coord if valid_move(pos: coord) && board.board[coord].contains_white_piece?
      end
      
    end
    
    def possible_black_moves(board: Board.new)
      @possible_moves << "#{@x + y.coord - 1}"
      @possible_moves << "#{@x + y.coord - 2}".to_sym if moved? == false
      @possible_moves <<  black_diagonal_moves(board: board)
    end
    
    def possible_white_moves
    end
  end
end