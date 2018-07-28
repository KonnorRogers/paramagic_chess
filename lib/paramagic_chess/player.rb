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
    
    def check_mate?
      @check_mate
    end
    
    def check?
      @check
    end
  end
end