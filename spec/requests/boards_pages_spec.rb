require 'spec_helper'

describe "Boards pages" do
	let(:board) { FactoryGirl.create(:board) }
	let(:user) { FactoryGirl.create(:user) }
	let(:admin) { FactoryGirl.create(:admin) }
	let(:topic) { board.topics.build(user_id: user.id) }

	subject { page }

	describe "index" do
		before { visit boards_path }

		it { should have_content('Forums') }
		it { should have_title(full_title('All Boards')) }
	end

	describe "specific board" do
		before { visit board_path(board) }

		it { should have_title(full_title(board.title)) }

		it { should have_content(board.title) }
		it { should have_content(board.description) }
		it { should have_content(topic.title) }
		it { should_not have_content('Create new topic') }

		describe "when signed in" do
			before do
				sign_in(user)
				visit board_path(board)
			end
			it { should have_button('Create new topic') }
		end

		describe "when signed in as admin" do
			before do
				sign_in(admin)
				visit board_path(board)
			end
			it { should have_button('Create new topic') }
		end
	end # / specific board

end