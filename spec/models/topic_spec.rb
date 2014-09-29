require 'spec_helper'

describe Topic do
  let(:board) { create(:board) }
  let(:user) { create(:user) }
  let(:topic) { create(:topic, user: user, board: board) }

  subject { topic }

  it { should be_valid }

  its(:user) { should eq user }
  its(:board) { should eq board }
  its(:last_page) { should eq 1 }
  its(:sticky?) { should eq false }
  its(:locked?) { should eq false }

  describe "when #title is missing" do
    before { @no_title = Topic.new(title: " ", user_id: 1, board_id: 1) }
    it "should not be valid" do
      expect(@no_title).to_not be_valid
    end
  end

  describe "when #user is missing" do
    before { @no_user = Topic.new(title: "new", user_id: nil, board_id: 1) }
    it "should not be valid" do
      expect(@no_user).to_not be_valid
    end
  end

  describe "when #board is missing" do
    before { @no_board = Topic.new(title: "new", user_id: 1, board_id: nil) }
    it "should not be valid" do
      expect(@no_board).to_not be_valid
    end
  end

  describe "last page when there are many posts" do
    before do
      25.times do
        create(:post, user: user, topic: topic)
      end
    end
    its(:last_page) { should eq 2 }
  end

end
