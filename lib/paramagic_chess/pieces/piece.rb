module ParamagicChess
  class Piece
    attr_accessor :side, :possible_moves
    attr_reader :x, :y, :pos, :type, :moved

    def initialize(pos:, side: nil, moved: false)
      check_position(pos)
      @x = pos[0].to_sym
      @y = pos[1]
      @pos = pos
      @side = side
      @moved = moved
      @possible_moves = {}
    end

    def y_coord(pos:)
      pos.to_s.split(/[a-z]/)[1].to_i
    end

    def move_to(pos:)
      return "#{pos} is an invalid move. Try again." unless valid_move?(pos: pos)

      @pos = pos
      @x = pos[0].to_sym
      @y = y_coord(pos: pos)
      @moved = true if @moved == false
      # @possible_moves.update_possible_moves
      # TODO: implement update_possible_moves
    end

    def check_position(pos)
      raise ArgumentError, 'first coordinate must be a - h' unless pos[0] =~ /[a-h]/

      y = y_coord(pos: pos)
      raise ArgumentError, 'second coordinate must be 1 - 8' if y < 1 || y > 8
      true
    end

    def moved?
      @moved
    end

    private

    def valid_move?(pos:)
      y = y_coord(pos: pos)
      return false unless CHAR_TO_NUM.key?(pos[0].to_sym)
      return false if y > COORD_MAX || y < COORD_MIN

      true
    end
  end
end
