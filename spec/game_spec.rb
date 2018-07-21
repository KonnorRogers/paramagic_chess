module ParamagicChess
  RSpec.describe Game do
    let(:game) { Game.new }
    
    context '#initialize' do
      it 'creates a board' do
        expect(game.board).to be_an_instance_of Board
      end
      
      it 'creates an empty array for players' do
        expect(game.players).to be_empty
      end
      
      it 'has an array of safe words' do
        safe_words = %i{save load castle exit}
        expect(Game::SAFE_WORDS).to match_array safe_words
      end
    end
    
    context '#add_players(player1, player2, input)' do
      it 'will add only 1 player if playing against computer' do
        game.add_players(player1: 'konnor', input: :y)
        expect(game.players[0].name).to eq 'konnor'  
        expect(game.players[1]).to eq nil
      end
      
      it 'will add both players with input of :n' do
        game.add_players(player1: 'konnor', player2: 'evelyn', input: :n)
        expect(game.players[0].name).to eq 'konnor'
        expect(game.players[1].name).to eq 'evelyn'
      end
    end
  end
end
