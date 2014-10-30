require 'spec_helper'

describe "Post pages" do

	let!(:user) { create(:user) }
	let!(:board) { create(:board) }
	let!(:topic) { create(:topic, board: board, user: create(:user)) }
	before { create(:post, topic: topic, user: topic.user, content: "FIRST!") }

	subject { page }

	before { sign_in(user) }

	describe "creating a new post" do
		before do
			visit topic_path(topic)
			click_button "Reply to this topic"
			fill_in "post_content", with: "new post content"
			click_button "Post"
		end

		it { should have_content("new post content") }
		it { should have_content(user.username) }
	end

	describe "editing a post" do
		let!(:post) { create(:post, topic: topic, user: user, content: "Original Content") }
		before do
			visit topic_path(topic)
			click_link "Edit"
			fill_in "post_content", with: "Edited Content"
			click_button "Save changes"
		end

		it { should have_content("Edited Content") }
		it { should_not have_content("Original Content") }
		it { should have_content(user.username) }
	end

	describe "using the post permalink" do
		let!(:post) { create(:post, topic: topic, user: user, content: "Permalinked Content") }
		before do
			visit user_path(user)
			click_link "Permalink"
		end

		it { should have_content("Permalinked Content") }
		it { should have_content(topic.title) }
	end

end