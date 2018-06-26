module ParamagicChess
  class Board
    attr_accessor :board

    def initialize
      @board = create_board
      place_all_pieces
    end
    
    def max_index
      8
    end

    def print_board
      system 'clear'
      index = 0
      print "\t   A  B  C  D  E  F  G  H"

      @board.each do |_key, value|
        print "\n\t" if index % 8 == 0
        print "\e[0m#{(index / 8) + 1} " if index % 8 == 0
        print value.to_s
        index += 1
      end

      puts "\e[0m"
    end

    private

    def place_all_pieces
      place_pieces
      place_pawns
      change_to_black
      change_to_white
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
        when :d
          tile.piece = King.new(pos: key)
        when :e
          tile.piece = Queen.new(pos: key)
        end
      end
    end

    def change_to_white
      # `1-2 is white side
      @board.each { |key, tile| tile.piece.side = :white if tile.contains_piece? && key[1].to_i <= 2 }
    end

    def change_to_black
      # 7-8 is black side
      @board.each { |key, tile| tile.piece.side = :black if tile.contains_piece? && key[1].to_i >= 7 }
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
