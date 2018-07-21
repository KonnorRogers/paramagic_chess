module ParamagicChess
  class Player
    attr_accessor :side, :name, :pieces
    
    def initialize(name:, side: nil)
      @side = side
      @name = name
      @pieces = []
    end
  end
end