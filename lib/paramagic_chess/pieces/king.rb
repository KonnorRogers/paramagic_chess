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
      rooks(board: board).each do |rook|
        return rook if rook.moved? == false && rook.x == NUM_TO_CHAR[x_coord]
      end
      nil
    end
    
    def rook_left(board:)
      x_coord = CHAR_TO_NUM[@x] - 4
      rooks(board: board).each do |rook|
        return rook if rook.moved? == false && rook.x == NUM_TO_CHAR[x_coord]
      end
      nil
    end
    
    def can_castle?(board:, direction:)
      # rook_method_name = ("rook_" + direction.to_s).to_sym
      rook = send("rook_#{direction}".to_sym, board: board)
      
      # +Neither the king nor the chosen rook has previously moved.
      return false if @moved == true || rook.moved? == true
      # +The king is not currently in check.
      return false if @check == true
      
      tiles = send("#{direction}_tiles".to_sym, board: board)
      
      # There are no pieces between the king and the chosen rook.
      return false if tiles_contain_a_piece?(tiles_array: tiles)
      # The king does not pass through a square that is attacked by an enemy piece.[4]
      return false if any_pieces_attacking_path?(board: board, tiles_array: tiles)
      
      # The king does not end up in check. (True of any legal move.)
      return false if end_path_results_in_check?(board: board, direction: direction)
      
      true
    end
    
    private
    
    def end_path_results_in_check?(board:, direction:)
      end_x = CHAR_TO_NUM[@x]
      
      end_x += 2 if direction == :right
      end_x -= 2 if direction == :left
      
      end_pos = to_pos(x: NUM_TO_CHAR[end_x], y: @y)
      
      board.board.each do |_coord, tile|
        next if tile.piece.nil?
        next if tile.side == @side
        tile.piece.update_moves(board: board)
        return true if tile.piece.possible_moves.include?(end_pos)
      end
      false
    end
    
    def any_pieces_attacking_path?(board:, tiles_array:)
      board.board.each do |_coord, tile|
        # checks if it has a piece
        next if tile.piece.nil?
        # checks to see if its a friendly
        next if tile.piece.side == @side
        
        # runs through the tile array to see if its position is contained as part of another piece
        # of the opposite side
        tiles_array.each do |defending_tile|
          tile.piece.update_moves(board: board)
          if tile.piece.possible_moves.include?(defending_tile.position)
            return true
          end
        end
      end
      
      false
    end
    
    def tiles_contain_a_piece?(tiles_array:)
      tiles_array.any? { |tile| tile.contains_piece? }
    end
    
    def right_tiles(board:)
      tiles = []
      acceptable_coords = %i{f g}
      board.board.each do |coord, tile|
        next if coord[1].to_i != @y
        coord_x = coord[0].to_sym
        
        next unless acceptable_coords.include?(coord_x)
        tiles << tile
      end
      tiles
    end
    
    def left_tiles(board:)
      tiles = []
      acceptable_coords = %i{d c b}
      board.board.each do |coord, tile|
        next if coord[1].to_i != @y
        coord_x = coord[0].to_sym
        next unless acceptable_coords.include?(coord_x)
        
        tiles << tile
      end
      
      tiles
    end
  end
end