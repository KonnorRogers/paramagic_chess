require_relative 'player.rb'

module ParamagicChess
  class Computer < Player
    def initialize(name: :computer, side: nil)
      super
    end
  end
end
