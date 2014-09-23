require 'spec_helper'

describe "User pages" do

	subject { page }

	describe "signup page" do
		before { visit signup_path }

		it { should have_content('Sign Up') }
		it { should have_title(full_title('Sign Up')) }
	end # signup page

	describe "profile page" do
		let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.username) }
    it { should have_title("Profile for #{user.username}") }
	end # profile page

	describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Username",     with: "Example"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end # signup

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do 
      sign_in(user)
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content("Settings") }
      it { should have_title("Settings") }
    end

    describe "with invalid information" do
      let(:bad_email) { "new@example" }
      before do
        fill_in "Email", with: bad_email
        click_button "Save changes"
      end

      it { should have_content('Email is invalid') }
    end

    describe "with valid information" do
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Email",            with: new_email
        click_button "Save changes"
      end

      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { expect(user.reload.email).to eq new_email }
    end
  end # edit

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_title('Users') }
    it { should have_content('Users') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('td', text: user.username)
        end
      end
    end
  end # index

end