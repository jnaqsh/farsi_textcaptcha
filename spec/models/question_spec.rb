require 'spec_helper'

describe Question do
  context 'validations' do
    it {should validate_uniqueness_of(:question).case_insensitive}
    it {should validate_presence_of(:question)}
  end
end
