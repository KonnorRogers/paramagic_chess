module ParamagicChess
  class Pawn < Piece
    def initialize(pos:, side: nil)
      super
      @type = :pawn
    end

    def to_s
      return "\u2659" if @side == :white
      return "\u265f" if @side == :black
      'Side not set'
    end
    
    def move_to(pos:)
      super
      
      
    end
    
    def black_diagonal_moves
      array = []
      x = @x.to_num
      
      array << (x + 1).sym.to_s + y.coord - 1
      array << (x - 1).sym.to_s + y.coord - 1
      
      array.select { |coord| coord if valid_move(pos: coord) }
      
    end
    
    def possible_black_moves
      @possible_moves << "#{@x + y.coord - 1}"
      @possible_moves << "#{@x + y.coord - 2}".to_sym if moved? == false
      @possible_moves <<  black_diagonal_moves
    end
    
    def possible_white_moves
    end
  end
end