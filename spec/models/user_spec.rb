require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { build(:user) }

  let(:profile) { build(:profile, user_id: user.id) }


   describe "Associations" do
     it "has one profile" do
       assc = described_class.reflect_on_association(:profile)
       expect(assc.macro).to eq :has_one
     end

     it "has many posts" do
       assc = described_class.reflect_on_association(:posts)
       expect(assc.macro).to eq :has_many
     end

     it "has many comments" do
       assc = described_class.reflect_on_association(:comments)
       expect(assc.macro).to eq :has_many
     end

     it "has many likes" do
       assc = described_class.reflect_on_association(:likes)
       expect(assc.macro).to eq :has_many
     end

     it "has many accepted sent requests" do
       assc = described_class.reflect_on_association(:accepted_sent_requests)
       expect(assc.macro).to eq :has_many
     end

     it "has many friends" do
       assc = described_class.reflect_on_association(:friends)
       expect(assc.macro).to eq :has_many
     end

     it "has many sent requests" do
       assc = described_class.reflect_on_association(:sent_requests)
       expect(assc.macro).to eq :has_many
     end

     it "has many requestees" do
       assc = described_class.reflect_on_association(:requestees)
       expect(assc.macro).to eq :has_many
     end

     it "has many requesters" do
       assc = described_class.reflect_on_association(:requesters)
       expect(assc.macro).to eq :has_many
     end

     it "has many received requests" do
       assc = described_class.reflect_on_association(:received_requests)
       expect(assc.macro).to eq :has_many
     end

   end



  describe ".search" do
     it { expect(described_class.search("Mreda")).to include(user) }
     it { expect(described_class.search("Parker")).to include(user) }
 end

  it "is valid with valid attributes" do
    expect(user).to be_valid
  end

  context 'is not valid without a first name' do
    it 'first name is nil' do
      user.first_name = nil
      expect(user).not_to be_valid
    end
  end

  context 'is not valid without a last name' do
    it 'last name is nil' do
      user.last_name = nil
      expect(user).not_to be_valid
    end
  end

  context 'is not valid without a valid email' do
    it 'email is nil' do
      user.email = nil
      expect(user).not_to be_valid
    end
    it 'is missing an "@"' do
      user.email = 'kyle.email.com'
      expect(user).not_to be_valid
    end
    it 'is missing a "."' do
      user.email = 'kyle@email'
      expect(user).not_to be_valid
    end
  end

  context "is not valid without a valid password" do
    it 'is too short' do
      user.password = 'pass'
      expect(user).not_to be_valid
    end
    it 'is too long' do
      user.password = 'a'*129
      expect(user).not_to be_valid
    end
  end

  describe '#make_profile' do
    it 'creates a profile after a new user is created' do
      user.save
      expect(user.profile).not_to be nil
    end
  end
end
