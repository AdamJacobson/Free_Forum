require 'spec_helper'

describe Post do
	let(:user) { create(:user) }
	let(:board) { create(:board) }
	let(:topic) { create(:topic, board: board, user: user) }
	let(:post) { create(:post, user: user, topic: topic) }

	subject { post }

	it { should be_valid }

	its (:page) { should eq 1 }
	its (:user) { should eq user }
	its (:topic) { should eq topic }
	its (:anchor) { should eq "post-#{post.id}" }
	its (:permalink) { should eq "/topics/#{post.topic.id}?page=#{post.page}##{post.anchor}" }

	describe "page number with 21 posts" do
		before do
			20.times do 
				FactoryGirl.create(:post, user: user, topic: topic)
			end
		end
		it { expect(post.topic.posts.last.page).to eq 2 }
	end

	describe "when #content is missing" do
		before { @no_content = Post.new(user: user, topic: topic, content: "") }
		it "should not be valid" do
			expect(@no_content).to_not be_valid
		end
	end

	describe "when #user is missing" do
		before { @no_user = Post.new(user: nil, topic: topic, content: "Content") }
		it "should not be valid" do
			expect(@no_user).to_not be_valid
		end
	end

	describe "when #topic is missing" do
		before { @no_topic = Post.new(user: user, topic: nil, content: "Content") }
		it "should not be valid" do
			expect(@no_topic).to_not be_valid
		end
	end

end
