RSpec.describe ParamagicChess do
  it 'has a version number' do
    expect(ParamagicChess::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(true).to eq(true)
  end
  
  it 'has a CHAR_TO_NUM hash' do
    expect(ParamagicChess::CHAR_TO_NUM).to be_an_instance_of Hash
    expect(ParamagicChess::CHAR_TO_NUM[:c]).to eq 3
  end
  
  it 'has a NUM_TO_CHAR hash' do
    expect(ParamagicChess::NUM_TO_CHAR).to be_an_instance_of Hash
    expect(ParamagicChess::NUM_TO_CHAR[3]).to eq :c
  end
  
  context '#to_symbol(num)' do
    it 'sets 2 equal to :b' do
      expect(ParamagicChess.to_symbol(2)).to eq :b
    end
  end
  
  context '#to_num(symbol)' do
    it 'sets :b equal to 2' do
      expect(ParamagicChess.to_num(:b)).to eq 2
    end
  end
end
