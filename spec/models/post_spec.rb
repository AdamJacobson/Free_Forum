require 'spec_helper'

describe Post do
	let(:user) { create(:user) }
	let(:board) { create(:board) }
	let(:topic) { create(:topic, board: board, user: user) }
	let(:post) { create(:post, user: user, topic: topic) }

	subject { post }

	it { should be_valid }
	it { expect(post.page).to eq 1 }
	it { expect(post.user).to eq user }
	it { expect(post.topic).to eq topic }
	it { expect(post.anchor).to eq "post-#{post.id}" }
	it { expect(post.permalink).to eq "/topics/#{post.topic.id}?page=#{post.page}##{post.anchor}" }

	describe "page number with 21 posts" do
		before do
			20.times do 
				FactoryGirl.create(:post, user: user, topic: topic)
			end
		end
		describe "when there are 21 posts" do
			it { expect(post.topic.posts.last.page).to eq 2 }
		end
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
