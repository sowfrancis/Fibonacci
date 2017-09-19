require "rails_helper"

RSpec.describe UserMailer, type: :mailer do

  describe 'send email to user after sign up' do
    let(:user) { Fabricate(:user) }
    let(:situation) { Fabricate(:situation, user: user) }
    let(:technical_info) { Fabricate(:technical_info, user: user) }
    let(:mail) { described_class.email_after_sign_up(user).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq('Merci pour votre inscription!')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

  end
end
