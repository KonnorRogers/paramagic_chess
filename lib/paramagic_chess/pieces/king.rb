module ParamagicChess
  class King < Piece
    MOVE_SET = Box.new
    
    attr_reader :check, :check_mate

    def initialize(pos: nil, side: nil, moved: false)
      super
      @type = :king
      @check = false
      @check_mate = false
    end
    
    def positions_attacking_king(board:)
      positions = []
      board.each do |coord, tile|
        next if tile.piece.nil?
        piece = tile.piece
        # checks that it is from a different side
        next if piece.side == @side
        piece.update_moves(board: board)
        if piece.possible_moves.include?(pos)
          positions << coord
        end
      end
      # returns array of pieces attacking the king
      positions
    end
    
    def cannot_save?(board:)
      threats = positions_attacking_king(board: board)
      board.each do |coord, tile|
        next if tile.piece.nil?
        piece = tile.piece
        next if piece.side != @side
        piece.update_moves(board: board)
        threats.each do |pos|
          return false if piece.possible_moves.include?(pos)
        end
      end
      
      true
    end
    
    def check_mate?(board:)
      # will be called part of check? && cannot_save?
      # update_moves(board: board)
      if check?(board: board, pos: @pos) && has_no_moves?
        if cannot_save? == true
          @check_mate = true
          return true
        end
      end
      
      @check_mate = false
      false
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
        if check?(board: board, pos: pos)
          puts "Your king will be captured if you move there."
          return nil
        else
          super
        end
      end
      true
    end
    
    def check?(board:, pos: @pos)
      board.board.each do |_coord, tile|
        next if tile.piece.nil?
        piece = tile.piece
        next if piece.side == @side
        piece.update_moves(board: board)
        if piece.possible_moves.include?(pos)
          @check = true
          return true
        end
      end
      @check = false
      false
    end
    
    def rooks(board:)
      rook_array = []
      board.board.each do |_coord, tile|
        next if tile.piece.nil?
        next if tile.piece.type != :rook
        next if tile.piece.side != @side
        
        rook_array << tile.piece
      end
      
      rook_array
    end
    
    def rook_right(board:)
      # :e => 5, 5 + 3 = 8, 8 => :h
      # h1 for blue, h8 for red
      x_coord = CHAR_TO_NUM[@x] + 3
      my_rooks.each do |rook|
        return rook if rook.moved? == false && rook.x == x_coord 
      end
    end
    
    def rook_left(board:)
      
    end
    
    def can_castle?
    # The king and the chosen rook are on the player's first rank.[3]
    # Neither the king nor the chosen rook has previously moved.
    # There are no pieces between the king and the chosen rook.
    # The king is not currently in check.
    # The king does not pass through a square that is attacked by an enemy piece.[4]
    # The king does not end up in check. (True of any legal move.)
    end
    
    def castle_right
      
    end
    
    def castle_left
    end
  end
end