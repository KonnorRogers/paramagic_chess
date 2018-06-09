module ParamagicChess
  class Board
    attr_accessor :board

    def initialize
      @board = create_board
    end

    def create_board
      board = {}

      (a..h).each do |letter|
        (1..9).each do |num|
          board["#{letter}#{num}"] = Tile.new
        end
      end

      board
    end
  end
end
