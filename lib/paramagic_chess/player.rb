module ParamagicChess
  class Player
    attr_accessor :side, :name, :pieces, :has_castled
    attr_reader :check, :check_mate
    
    
    def initialize(name:, side: nil)
      @side = side
      @name = name
      @pieces = []
      @check_mate = false
      @check = false
      @has_castled = false
    end
    
    def has_castled?
      @has_castled
    end
    
    def get_king
      @pieces.each { |piece| return piece if piece.type == :king && piece.side == @side } 
    end
    
    def find_king(board:, side: @side)
      board.board.each do |_coord, tile| 
        next if tile.piece.nil?
        if tile.piece.type == :king && tile.piece.side == side
          return tile.piece
        end
      end
    end
    
    def check_mate?
      return @check_mate = true if get_king.check_mate? == true
      false
    end
    
    def check?
      return @check = true if get_king.check? == true
      false
    end
  end
end