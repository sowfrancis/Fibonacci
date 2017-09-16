require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'user is valid' do
    let(:user) { Fabricate(:user, email: 'sow@gmail.com', password: 'Spiderman1') }

    it 'is valid with the right format email' do
      expect(user).to be_valid
    end

    it 'is valid with right password format' do
      expect(user).to be_valid
    end
  end

  describe 'user not valid' do

    it 'is not valid with wrong password format' do
      user = Fabricate.build(:user, email: 'sow@gmail.com', password: 'spiderman')
      expect(user).to_not be_valid
    end

    it 'is not valid with the wrong format email' do
      user = Fabricate.build(:user, email: 'sow.gmail.com', password: 'spiderman')
      expect(user).to_not be_valid
    end
  end

end
