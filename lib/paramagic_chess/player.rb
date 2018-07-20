module ParamagicChess
  class Player
    attr_accessor :side, :name
    
    def initialize(name:)
      @side = nil
      @name = name
    end
  end
end