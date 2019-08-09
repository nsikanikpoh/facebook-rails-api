require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }
  let(:post) { build(:post, user_id: user.id) }

  it "is valid with content" do
    expect(post).to be_valid
  end



   describe "Associations" do
      it { should belong_to(:user) }

     it "has many comments" do
       assc = described_class.reflect_on_association(:comments)
       expect(assc.macro).to eq :has_many
     end

     it "has many likes" do
       assc = described_class.reflect_on_association(:likes)
       expect(assc.macro).to eq :has_many
     end

  end

  it "is not valid without content" do
    post.content = '   '
    expect(post).not_to be_valid
  end

  it 'is not valid without a valid user_id' do
    post.user_id = 0
    expect(post).not_to be_valid
  end
end
