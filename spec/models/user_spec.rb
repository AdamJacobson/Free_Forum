require 'spec_helper'

describe User do
  before { @user = User.new(username: "Example", email: "example@email.com", password: "foobar", password_confirmation: "foobar") }

  subject { @user }

  it { should respond_to(:username) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) }
  it { should respond_to(:posts) }

  it { should be_valid }
  it { should_not be_admin }

  describe "with admin attribute set to 'true'" do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
  end

  # password

  describe "when password is not present" do
  	before do
     @user = User.new(username: "Example User", email: "user@example.com",
       password: " ", password_confirmation: " ")
   end
   it { should_not be_valid }
 end

 describe "with a password that's too short" do
  before { @user.password = @user.password_confirmation = "a" * 5 }
  it { should be_invalid }
end

describe "with a password that's too long" do
  before { @user.password = @user.password_confirmation = "a" * 73 }
  it { should be_invalid }
end

describe "return value of authenticate method" do
  before { @user.save }
  let(:found_user) { User.find_by(email: @user.email) }

  describe "with valid password" do
    it { should eq found_user.authenticate(@user.password) }
  end

  describe "with invalid password" do
    let(:user_for_invalid_password) { found_user.authenticate("invalid") }

    it { should_not eq user_for_invalid_password }
    specify { expect(user_for_invalid_password).to be_false }
  end
end

describe "when password doesn't match confirmation" do
 before { @user.password_confirmation = "mismatch" }
 it { should_not be_valid }
end

	# username

  describe "when username is not present" do
    before { @user.username = " " }
    it { should_not be_valid }
  end

  describe "when username is too long" do
  	before { @user.username = 'a' * 21 }
  	it { should_not be_valid }
  end

  # email

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
       foo@bar_baz.com foo@bar+baz.com foo@bar..com @ross.lm]
       addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPle.CoM" }

    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end

  # Ranks

  describe "ranks" do
    let!(:admin_user) { create(:admin) }

    describe "when no user defined ranks exist" do
      its(:rank) { should be_nil }
      its(:rank_style) { should be_empty }
      its(:rank_title) { should be_empty }

      it "admins should still be ranked as admins" do
        expect(admin_user.rank).to eq Rank.admin
        expect(admin_user.rank_style).to eq "color: #{Rank.admin.color};"
        expect(admin_user.rank_title).to eq "#{Rank.admin.title}"
      end
    end

    describe "when user has met the requirements" do
      let!(:rank) { create(:rank, requirement: 0) }

      its(:rank) { should be_nil }
      its(:rank_style) { should be_empty }
      its(:rank_title) { should be_empty }

      describe "and update_user_rank is triggered" do
        before { @user.update_user_rank }

        its(:rank) { should eq rank }
        its(:rank_style) { should eq "color: #{rank.color};" }
        its(:rank_title) { should eq "#{rank.title}" }
      end
    end
  end

  # Moderating

  describe "moderating" do
    let!(:user) { create(:user) }
    let!(:board) { create(:board) }
    let!(:rank) { create(:rank, requirement: 0) }

    subject { user }

    before { user.update_user_rank }

    describe "by default" do
      its(:moderating) { should be_empty }
    end

    describe "when user is a moderator" do
      before { ModeratorJoin.create(user: user, board: board) }
      
      its(:moderating) { should include board }
      its(:rank) { should eq rank }
      its(:rank_style) { should eq "color: #{rank.color};" }
      its(:rank_title) { should eq "#{rank.title}" }
    end
  end
  
end