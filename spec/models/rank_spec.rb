require 'spec_helper'

describe Rank do 

	let(:rank) { create(:rank) }
	
	subject { rank }

	it { should be_valid }
	its(:system) { should be_false }

	describe "with duplicate title" do
		before { Rank.create(title: "DuplicateRank", requirement: 332, color: "#000000") }

		let(:rank2) { Rank.new(title: "DuplicateRank", requirement: 567, color: "#000000") }

		it "should not be valid" do 
			expect(rank2).to_not be_valid
		end
	end

	describe "with duplicate requirements" do
		before { Rank.create(title: "Rank47", requirement: 25, color: "#000000") }

		let(:rank2) { Rank.new(title: "Rank53", requirement: 25, color: "#000000") }

		it "should not be valid" do 
			expect(rank2).to_not be_valid
		end
	end

	describe "with duplicate requirements for a SYSTEM rank" do
		let(:rank2) { Rank.new(title: "Rank4", requirement: 42, color: "#000000", system: true) }

		it "should be valid" do 
			expect(rank2).to be_valid
		end
	end

	describe "with different requirements" do
		let(:rank2) { create(:rank, title: "Rank_comp", requirement: 124) }

		it "should be comparable" do
			expect(rank < rank2).to be_true
		end
	end

	describe "with negative requirements" do
		let(:rank2) { Rank.new(title: "Rank4", requirement: -5, color: "#000000") }

		it "should not be valid" do 
			expect(rank2).to_not be_valid
		end
	end

	describe "with a too long title" do
		let(:rank2) { Rank.new(title: "RankRankRankRank", requirement: 77, color: "#000000") }

		it "should not be valid" do 
			expect(rank2).to_not be_valid
		end
	end

	describe "when color is not a valid hex value" do
		let(:rank2) { Rank.new(title: "Rank4", requirement: 99) }

		it "should be invalid" do
			color = %w[F0F0F0 #aBcDe #00000G #fff FFF012 ##FF00FF #F0000FA]
			color.each do |c|
				rank2.color = c
				expect(rank2).not_to be_valid
			end
		end
	end

	describe "when color is a valid hex value" do
		let(:rank2) { Rank.new(title: "Rank4", requirement: 99) }

		it "should be valid" do
			color = %w[#F0f0F0 #ABCDEf #000000 #1234Fd]
			color.each do |c|
				rank2.color = c
				expect(rank2).to be_valid
			end
		end
	end

end