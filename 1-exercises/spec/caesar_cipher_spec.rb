require_relative 'spec_helper'

describe '#caesar_cipher' do 
  it 'shifts a character along the alphabet n times' do
    expect(caesar_cipher('a', 2)).to eq 'c'
    expect(caesar_cipher('a', 3)).to eq 'd'
  end

  it 'loops at the end of the alphabet' do
    expect(caesar_cipher('z', 2)).to eq 'b'
  end

  it 'loops at the beginning of the alphabet' do
    expect(caesar_cipher('a', -2)).to eq 'y'
  end

  it 'shifts all characters in entire strings' do
    expect(caesar_cipher("what a string", 5)).to eq "bmfy f xywnsl"
  end

  it 'maintains non-word symbols' do
    expect(caesar_cipher('a!', 2)).to eq 'c!'
  end

  it 'maintains capitals' do
    expect(caesar_cipher('A', 2)).to eq 'C'
  end

end