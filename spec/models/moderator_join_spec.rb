require 'spec_helper'

describe ModeratorJoin do
	let(:user) { create(:user) }
	let(:board) { create(:board) }
	let!(:join) { ModeratorJoin.create(user: user, board: board) }

	subject { join }

	it { should be_valid }
	its(:id) { should_not eq nil }
	its(:user) { should eq user }
	its(:board) { should eq board }

	describe "without a user" do
		let(:join2) { ModeratorJoin.new(user: nil, board: board) }

		it "should not be valid" do
			expect(join2).to_not be_valid
		end
	end

	describe "without a board" do
		let(:join2) { ModeratorJoin.new(user: user, board: nil) }

		it "should not be valid" do
			expect(join2).to_not be_valid
		end
	end

	describe "board can have many moderators" do
		let(:join2) { ModeratorJoin.new(user: create(:user), board: board) }

		it "should be valid" do
			expect(join2).to be_valid
		end
	end

	describe "user can moderate many boards" do
		let(:join2) { ModeratorJoin.new(user: user, board: create(:board)) }

		it "should be valid" do
			expect(join2).to be_valid
		end
	end

	describe "user/board pairs" do
		let(:join2) { ModeratorJoin.new(user: user, board: board) }

		it "must be unique" do
			expect(join2).to_not be_valid
		end
	end

end 