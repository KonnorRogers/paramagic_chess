module ParamagicChess
  class King < Piece
    MOVE_SET = Box.new

    def initialize(pos: nil, side: nil, moved: false)
      super
      @type = :king
      @check = false
      @check_mate = false
    end
    
    def other_side
      return :blue if @side == :red
      return :red if @side == :blue
      nil
    end

    def to_s
      king = "\u265a"
      return king.blue if @side == :blue
      return king.red if @side == :red
      'Side not set'
    end
    
    def update_moves(board:)
      @possible_moves = []
      @possible_moves.concat(MOVE_SET.possible_moves(board: board, piece: self))
    end
    
    def has_no_moves?
      return true if @check == true && @possible_moves.empty?
      false
    end
    
    def move_to(board:, pos:)
      update_moves(board: board)
      unless @possible_moves.include? pos
        puts ":#{pos} is an invalid move. Try again."
        return nil
      end
      if @possible_moves.include? pos && !can_be_captured?(board: board, pos: pos)
        super
      end
      true
    end
    
    def can_be_captured?(board:, pos:)
      board.board.each do |_coord, tile|
        next if tile.nil?
        piece = tile.piece
        next if piece.side == @side
        piece.update_moves(board: board)
        return true if piece.possible_moves.include?(pos)
      end
      false
    end
  end
end