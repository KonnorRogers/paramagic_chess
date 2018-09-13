module ParamagicChess
  class Board
    attr_accessor :board, :removed_red_pieces, :removed_blue_pieces
    MIN_INDEX = 1
    MAX_INDEX = 8

    def initialize
      @board = create_board
      place_all_pieces
      @removed_blue_pieces = []
      @removed_red_pieces = []
    end
    
    # required for evaluation of en_passant
    def reset_pawn_double_move(side:)
      @board.each do |_coord, tile|
        next if tile.piece.nil?
        if tile.piece.side == side && tile.piece.type == :pawn
          tile.piece.double_move = false
        end
      end
    end
    
    def tile(pos:)
      @board[pos]
    end
    
    def piece(pos:)
      @board[pos].piece
    end
    
    def find_king(side:)
      @board.each do |_coord, tile| 
        next if tile.piece.nil?
        if tile.piece.type == :king && tile.piece.side == side
          return tile.piece
        end
      end
    end

    def print_board
      # system 'clear'
      grid_letters = "            A   B   C   D   E   F   G   H"
      index = 0
      print grid_letters
      grid_num = nil

      @board.each do |_key, value|
        # sets the num between 1 - 8
        grid_num = index / 8  
        new_line = index % 8 == 0

        print " #{grid_num}" if new_line && index > 0
        print "\n\t" if new_line
        print "\e[0m #{grid_num + 1} " if new_line
        print value.to_s
        index += 1
      end

      puts " #{grid_num + 1}\e[0m"
      puts grid_letters
    end

    private

    def place_all_pieces
      place_pieces
      place_pawns
      change_to_red
      change_to_blue
    end

    def place_pieces
      row = @board.select { |key, _value| key[1].to_i == 1 || key[1].to_i == 8 }
      row.each do |key, _tile|
        column = key[0].to_sym
        tile = @board[key]

        case column
        when :a, :h
          tile.piece = Rook.new(pos: key)
        when :b, :g
          tile.piece = Knight.new(pos: key)
        when :c, :f
          tile.piece = Bishop.new(pos: key)
        when :e
          tile.piece = King.new(pos: key)
        when :d
          tile.piece = Queen.new(pos: key)
        end
      end
    end

    def change_to_blue
      # `1-2 is blue side
      @board.each { |key, tile| tile.piece.side = :blue if tile.contains_piece? && key[1].to_i <= 2 }
    end

    def change_to_red
      # 7-8 is red side
      @board.each { |key, tile| tile.piece.side = :red if tile.contains_piece? && key[1].to_i >= 7 }
    end

    def place_pawns
      @board.each do |key, tile|
        num = key[1].to_i
        # Only selects 2nd and 7th row
        next unless num == 2 || num == 7

        tile.piece = Pawn.new(pos: key)
      end
    end

    def create_board
      board = {}

      (1..8).each do |num|
        ('a'..'h').each do |letter|
          position = "#{letter}#{num}".to_sym
          board[position] = Tile.new(position: position)
        end
      end

      change_tile_background(board: board)
      board
    end

    def change_tile_background(board:)
      index = 0
      swap = 0

      board.each do |_key, value|
        value.background = :black if index.odd? && swap.even?
        value.background = :white if index.even? && swap.even?

        value.background = :black if index.even? && swap.odd?
        value.background = :white if index.odd? && swap.odd?

        index += 1
        swap += 1 if index % 8 == 0
      end
    end
  end
end
