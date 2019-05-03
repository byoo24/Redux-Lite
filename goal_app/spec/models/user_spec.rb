# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'spec_helper'
require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_length_of(:password).is_at_least(2) }

  describe 'uniqueness' do
    before(:each) do
      create(:user)
    end
    
    it { should validate_uniqueness_of(:session_token)}
  end

  describe '#is_password?' do
    let!(:user) { create(:user) }

    context 'with valid password' do
      it 'shoudl return true' do
        expect(user.is_password?('pokemon')).to be(true)
      end
    end

    context 'with invalid password' do
      it 'shoudl return false' do
        expect(user.is_password?('squirtle')).to be(false)
      end
    end
  end



end
