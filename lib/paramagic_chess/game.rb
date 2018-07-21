module ParamagicChess
  class Game
    SAFE_WORDS = [:save, :load, :castle]
    
    def initialize
      @board = Board.new
      @players = []
    end
    
    def add_players(player1: nil, player2: nil, input: nil)
      add_player_one(player1)
      
      add_computer_or_player(player2: player2, input: input)
    end
    
    def play
      greeting_message
      add_players
      # loop do
        
      # end
    end
    
    def check
    end
    
    def greeting_message
      system 'clear'
      puts "Welcome to ParamagicChess. Theres nothing magical here \n
            Just Chess."
    end
    
    private
    
    def add_player(name: nil)
      puts "What is your name? \n"
      name ||= gets.chomp
      @players << Player.new(name)
    end
    
    def add_computer_or_player(player: nil, input: nil)
      loop do
        input ||= gets.chomp.to_sym
        if input == :y
          # Adds a computer
          # To be implemented later
          break
        elsif input == :n
          add_player(name: player)
          break
        else
          puts "Please enter Y/N to play against a computer"
        end
      end
    end
    
    def check_mate
    end
    
    def castle
    end
    
    def input(input: gets.chomp)
      SAFE_WORDS.include?(input.to_sym)
    end
  end
end