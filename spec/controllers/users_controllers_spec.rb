require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'users' do

    context 'User process creation' do
      it 'create a user' do
        post :create , params: { user: Fabricate.attributes_for(:user) }
        expect(User.count).to eq 1
        expect(User.last.aasm_state).to eq 'second_step'
        #next_step

        user = User.find(session[:user_id])
        situation = Fabricate(:situation, user: user)
        tech_info = Fabricate(:technical_info, user: user)

        @attr = { situation_id: situation, technical_info_id: tech_info }

        put :update, params: { id: user.id, user: @attr  }
        user.reload

        expect(user.aasm_state).to eq 'completed'
        expect(situation.user.id).to eq user.id
        expect(tech_info.user.id).to eq user.id
      end
    end
  end
end
