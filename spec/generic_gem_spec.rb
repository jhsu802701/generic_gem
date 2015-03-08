require 'spec_helper'

describe GenericGem do
  it 'has a version number' do
    expect(GenericGem::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end
