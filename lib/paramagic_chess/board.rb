module ParamagicChess
  class Board
    attr_accessor :board

    def initialize
      @board = create_board
      # @board.set_background
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

      board
    end

    # def set_background
    # end
  end
end
