require 'spec_helper'

describe "Static pages" do

	let(:base_title) { "Free Forum" }

  describe "Home page" do
    it "should have the content 'Free Forum'" do
      visit '/static_pages/home'
      expect(page).to have_content("Free Forum")
    end

    it "should have the title 'Home'" do
      visit '/static_pages/home'
      expect(page).to have_title("#{base_title} | Home")
    end
  end

  describe "Help page" do
  	it "should have the content 'Help'" do
  		visit '/static_pages/help'
  		expect(page).to have_content("Help")
  	end

  	it "should have the title 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_title("#{base_title} | Help")
    end
  end

  describe "About page" do
  	it "should have the content 'About Us'" do
  		visit '/static_pages/about'
  		expect(page).to have_content("About Us")
  	end

  	it "should have the title 'About'" do
      visit '/static_pages/about'
      expect(page).to have_title("#{base_title} | About")
    end
  end

end