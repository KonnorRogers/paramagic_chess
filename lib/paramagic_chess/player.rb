module ParamagicChess
  class Player
    attr_accessor :side, :name, :turn
    
    def initialize(name:)
      @side = nil
      @name = name
      @turn = false
    end
  end
end