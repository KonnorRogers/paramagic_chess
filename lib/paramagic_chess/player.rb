module ParamagicChess
  class Player
    attr_accessor :side, :name, :pieces
    attr_writer :check, :check_mate
    
    
    def initialize(name:, side: nil)
      @side = side
      @name = name
      @pieces = []
      @check_mate = false
      @check = false
    end
    
    def get_king
      @pieces.select { |piece| piece.type == :king } 
    end
    
    def check_mate?
      @check_mate
    end
    
    def check?
      @check
    end
  end
end