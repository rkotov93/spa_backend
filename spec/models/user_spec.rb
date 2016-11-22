require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { create :user }

  it { is_expected.to be_valid }

  %w(name email).each do |attribute|
    describe "without #{attribute}" do
      before { user.public_send("#{attribute}=", nil) }

      it { is_expected.not_to be_valid }
    end
  end

  describe 'with the same email' do
    subject(:user_with_same_email) { build :user, email: user.email }

    it { is_expected.not_to be_valid }
  end
end
