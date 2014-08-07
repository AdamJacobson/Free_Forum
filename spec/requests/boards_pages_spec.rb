require 'spec_helper'

describe "Boards pages" do
	let(:board) { FactoryGirl.create(:board) }
	let(:user) { FactoryGirl.create(:user) }
	let(:topic) { board.topics.build(title: 'Test', user_id: user.id) }

	subject { page }

	describe "index" do
		before { visit boards_path }

		it { should have_content('All Boards') }
		it { should have_title(full_title('All Boards')) }
	end

	describe "specific board" do
		before { visit board_path(board) }

		it { should have_title(full_title(board.title)) }

		it { should have_content(board.title) }
		it { should have_content(board.description) }
		it { should have_content(topic.title) }
		it { should have_content(topic.user.username) }
		it { should_not have_content('Create new topic') }

		describe "when signed in" do
			before do
				sign_in(user)
				visit board_path(board)
			end
			it { should have_content('Create new topic') }
		end
	end # / specific board

end