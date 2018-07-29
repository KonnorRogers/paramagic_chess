module ParamagicChess
  class King < Piece
    MOVE_SET = Box.new

    def initialize(pos: nil, side: nil, moved: false)
      super
      @type = :king
      @check = false
      @check_mate = false
    end
    
    def get_pieces_attacking_king(board:)
      pieces = []
      board.each do |_coord, tile|
      
      end
    end
    
    def check_mate?(board:)
      update_moves(board: board)
      if can_be_captured(board: board, pos: @pos) && @possible_moves.empty?
        @check_mate = true
        return true
      end
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
      if @check == true && @possible_moves.empty?
        @check_mate = true
        return true
      end
      false
    end
    
    def move_to(board:, pos:)
      update_moves(board: board)
      unless @possible_moves.include? pos
        puts ":#{pos} is an invalid move. Try again."
        return nil
      end
      
      if @possible_moves.include? pos
        if can_be_captured?(board: board, pos: pos)
          puts "Your king will be captured if you move there."
          return nil
        end
        super
      end
      true
    end
    
    def can_be_captured?(board:, pos:)
      board.board.each do |_coord, tile|
        next if tile.piece.nil?
        piece = tile.piece
        next if piece.side == @side
        piece.update_moves(board: board)
        if piece.possible_moves.include?(pos)
          return true
        end
      end
      false
    end
  end
end