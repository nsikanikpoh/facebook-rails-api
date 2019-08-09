require 'rails_helper'

RSpec.describe Like, type: :model do

  let(:user) { create(:user) }  # equivalent to User.create({})
  let!(:user_post) { create(:post, user_id: user.id) }
  let(:like) { build(:like, user_id: user.id, post_id: user_post.id) }


   describe "Associations" do
      it { should belong_to(:user) }

      it { should belong_to(:post) }

  end
  it 'is valid with valid attributes' do
    expect(like).to be_valid
  end

  it 'is not valid without a valid post_id' do
    like.post_id = 0
    expect(like).not_to be_valid
  end

  it 'is not valid without a valid user_id' do
    like.user_id = 0
    expect(like).not_to be_valid
  end

  it 'cannot like a post twice' do
    like.save
    @like = build(:like)
    expect(@like).not_to be_valid
  end
end
