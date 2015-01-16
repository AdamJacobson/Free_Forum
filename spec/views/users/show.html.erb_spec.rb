require 'spec_helper'

describe "users/show.html.erb" do
	let!(:user) { create(:user) }
	let!(:board) { create(:board) }
	let!(:topic) { create(:topic, user: create(:user), board: board) }

	subject { page }

	describe "of a new user" do
		before { visit user_path(user) }

		it { should have_title(full_title("Profile for #{user.username}")) }
		it { should have_content(user.username) }
		it { should have_content(user.email) }
		it { should have_content("This user has no topics") }
		it { should have_content("This user has no posts") }
	end

	describe "for an admin" do
		let!(:admin) { create(:admin) }
		before do
			sign_in(admin)
			visit user_path(user)
		end

		it { should have_content("User Controls") }
		it { should have_content("Moderating Boards") }
	end

	describe "for a moderator" do
		let!(:moderator) { create(:user) }
		before do
			ModeratorJoin.create(board: board, user: moderator)
			sign_in(moderator)
			visit user_path(user)
		end

		it { should have_content("Grant user moderating privilages") }
		it { should have_selector("option") }
		it { should_not have_content("User Controls") }
		it { should_not have_content("Moderating Boards") }

		describe "after granting moderator privilages" do
			before do
				ModeratorJoin.create(board: board, user: user)
				visit user_path(user)
			end

			it { should have_content("You cannot grant this user any more moderating privilages") }
			it { should_not have_selector("option") }
		end
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