require 'spec_helper'

describe "users/show.html.erb" do
	let!(:user) { create(:user) }
	let!(:board) { create(:board) }
	let!(:topic) { create(:topic, user: create(:user), board: board) }

	subject { page }

	describe "by default" do
		before { visit user_path(user) }

		it { should have_title(full_title("Profile for #{user.username}")) }
		it { should have_content(user.username) }
		it { should have_content(user.email) }
		it { should have_content("This user has no topics") }
		it { should have_content("This user has no posts") }
	end

	describe "for an admin" do
		pending
	end

	describe "for a moderator" do
		pending
	end

	describe "with at least 1 post" do
		let!(:post) { create(:post, user: user, topic: topic) }
		before { visit user_path(user) }

		it { should have_content("Posts: 1") }
		it { should have_link("See all posts for #{user.username}") }
		it { should have_content(post.content) }
	end

	describe "with at least 1 topic" do
		let!(:topic) { create(:topic, user: user, board: board) }
		let!(:post) { create(:post, user: user, topic: topic) }
		before { visit user_path(user) }

		it { should have_content("Topics: 1") }
		it { should have_link("See all topics for #{user.username}") }
		it { should have_content(topic.title) }
	end

end