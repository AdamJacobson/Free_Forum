require 'spec_helper'

describe "Static pages" do

	let(:base_title) { "Free Forum" }

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_content("Free Forum") }
    it { should have_title(full_title('')) }
    it { should_not have_title('| Home') }
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_content("Help") }
    it { should have_title(full_title('Help')) }
  end

  describe "About page" do
    before { visit about_path }

		it { should have_content("About Us") }
    it { should have_title(full_title('About')) }
  end

end