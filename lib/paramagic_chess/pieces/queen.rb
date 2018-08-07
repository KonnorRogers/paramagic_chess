module ParamagicChess
  class Queen < Piece
    MOVE_SET = [Moves::Straight.new, Moves::Diagonal.new]
    
    def initialize(pos: nil, side: nil, moved: false)
      super
      @type = :queen
    end

    def to_s
      queen = "\u265b"
      return queen.blue if @side == :blue
      return queen.red if @side == :red

      'Side not set'
    end
    
    def update_moves(board:)
      @possible_moves = []
      moves = MOVE_SET.map do |move|
         move.possible_moves(board: board, piece: self)
      end
      
      @possible_moves.concat(moves.flatten)
    end
    
    def move_to(board:, pos:)
      update_moves(board: board)
      unless @possible_moves.include? pos
        puts ":#{pos} is an invalid move. Try again."
        return nil
      end
      
      super
    end
  end
end