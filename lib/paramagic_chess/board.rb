module ParamagicChess
  class Board
    attr_accessor :board

    def initialize
      @board = create_board
    end

    def print_board
      system 'clear'
      index = 0
      print "\t  A B C D E F G H"

      @board.each do |_key, value|
        print "\n\t" if index % 8 == 0
        print "#{(index / 8) + 1} " if index % 8 == 0
        print value.to_s
        index += 1
      end

      puts ''
    end

    private

    def create_board
      board = {}

      ('a'..'h').each do |letter|
        (1..8).each do |num|
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
