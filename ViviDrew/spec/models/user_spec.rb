# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { FactoryBot.build(:user, username: "drew", password: "password") }
  
  describe 'validations' do
    # FactoryBot.create(:user, username: "vivi", password_digest: "password", session_token: "doiscnslkdae")
    
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:session_token) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe '::generate_session_token' do
    it 'should generate a session token' do
      token = nil
      token = User.generate_session_token
      expect(token).not_to be_nil
    end
  end

  describe '#ensure_session_token' do
    it 'should create a session token if it does not exist' do
      user = User.new
      expect(user.session_token).not_to be_nil
    end
  end

  describe '#reset_session_token!' do
    it 'should reset a user\'s session token' do
      token = user.session_token
      user.reset_session_token!
      expect(token).to_not eq(user.session_token)
    end
  end

  describe '::find_by_credentials' do
    it 'should find a user by its username and password' do
      user.save!
      test = User.find_by_credentials(subject.username, subject.password)
      expect(test).to_not be_nil
      expect(test).to eq(subject)
    end
  end

  describe '#is_password?' do
    it 'should verify the user\'s password' do
      expect(user.is_password?("password")).to be true
      expect(user.is_password?("password1")).to be false
    end
  end
end
