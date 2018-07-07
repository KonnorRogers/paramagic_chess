module ParamagicChess
  class Bishop < Piece
    # MOVE_SET = Moves::Diagonal.new
    
    def initialize(pos: nil, side: nil, moved: false)
      super
      @type = :bishop
      @move_set = Moves::Diagonal.new
    end

    def to_s
      bishop = "\u265d"
      return bishop.blue if @side == :blue
      return bishop.red if @side == :red
      'Side not set'
    end
    
    def move_to(pos:, board:)
      update_moves(board: board)
      super if @possible_moves.include? pos
      return "#{pos} is not a valid move."
    end
    
    def update_moves(board:)
      @possible_moves = []
      @possible_moves.concat(@move_set.possible_moves(board: board, piece: self))
    end
  end
end
