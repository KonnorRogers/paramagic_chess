RSpec.describe ParamagicChess do
  it 'has a version number' do
    expect(ParamagicChess::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(true).to eq(true)
  end
  
  it 'has a CHAR_TO_NUM hash' do
    expect(ParamagicChess::CHAR_TO_NUM).to be_an_instance_of Hash
    expect(ParamagicChess::CHAR_TO_NUM[:c]).to eq 2 
  end
end
