require 'spec_helper'

describe Topic do
  let(:user) { FactoryGirl.create(:user) }
  before { @topic = user.topics.build(title: "New", board_id: 1) }

  subject { @topic }

  it { should respond_to(:title) }
  it { should respond_to(:user_id) }
  it { should respond_to(:board_id) }

  it { should respond_to(:user) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "with no title" do
    before { @topic = Topic.new(title: " ", user_id: 1, board_id: 1) }
  	it { should_not be_valid }
  end

  describe "with no user_id" do
    before { @topic = Topic.new(title: "new", user_id: nil, board_id: 1) }
    it { should_not be_valid }
  end

  describe "with no board_id" do
    before { @topic = Topic.new(title: "new", user_id: 1, board_id: nil) }
    it { should_not be_valid }
  end


end
