require 'rails_helper'

RSpec.describe Comment, type: :model do

  let(:user) { create(:user) }
  let(:user_post) { create(:post, user_id: user.id) }
  let(:comment) { build(:comment, user_id: user.id, post_id: user_post.id) }

  describe "Associations" do
     it { should belong_to(:user) }
     it { should belong_to(:post) }
   end

  it 'is valid with valid attributes' do
    expect(comment).to be_valid
  end

  it 'is valid without content' do
    comment.content = '   '
    expect(comment).to be_valid
  end

  it 'is not valid without a valid post_id' do
    comment.post_id = 0
    expect(comment).not_to be_valid
  end

  it 'is not valid without a valid user_id' do
    comment.user_id = 0
    expect(comment).not_to be_valid
  end

end
