module ParamagicChess
  class Board
    attr_accessor :board

    def initialize(size: 8)
      @board = create_board(size)
    end

    def create_board(size)
      board = {}

      (a..h).each do |letter|
        (1..9).each do |num|
          board["#{letter}#{num}"] = Tile.new
        end
      end
    end
  end
end
