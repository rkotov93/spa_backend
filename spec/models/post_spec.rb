# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create :user }
  subject(:post) { create :post, user: user }

  %w(title body user).each do |attribute|
    describe "without #{attribute}" do
      before { post.public_send("#{attribute}=", nil) }

      it { is_expected.not_to be_valid }
    end
  end

  describe 'with bery long title' do
    before { post.title = 'x' * 121 }

    it { is_expected.not_to be_valid }
  end
end
