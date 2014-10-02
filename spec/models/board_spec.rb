require 'spec_helper'

describe Board do
	let(:board) { create(:board) }
	let(:user) { create(:user) }

	subject { board }

	it { should be_valid }

	its(:required_rank) { should be_nil }
	its(:rank) { should be_nil }
	its(:moderators) { should be_empty }
	its(:topics) { should be_empty }
	its(:posts) { should be_empty }
	its(:locked?) { should be_false }

	describe "with a topic" do
		let(:topic) { create(:topic, user: user, board: board) }
		let(:post) { create(:post, user: user, topic: topic) }

		its(:topics) { should include topic }
		its(:posts) { should include post }
	end

	describe "with a moderator" do
		before { ModeratorJoin.create(user: user, board: board) }

		it "should have the user as a moderator" do
			board.moderator?(user).should be_true
			board.moderators.should include user
		end

		it "should not be available as a board to moderate" do
			Board.unique_to_moderator(user).should_not include board
		end
	end

end
