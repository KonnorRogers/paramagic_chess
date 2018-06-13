module ParamagicChess
  class Board
    attr_accessor :board

    def initialize
      @board = create_board
    end

    def print_board
      index = 0
      @board.each do |_key, value|
        print value.to_s
        index += 1
        puts '' if index % 8 == 0 && index != 0
      end
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
      board.each do |_key, value|
        value.background = :black if index.odd?
        value.background = :white if index.even?

        index += 1
      end
    end
  end
end
