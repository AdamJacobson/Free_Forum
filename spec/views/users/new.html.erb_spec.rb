describe "users/new.html.erb" do
	before { visit signup_path }

	subject { page }

	it { should have_content('Sign Up') }
	it { should have_title(full_title('Sign Up')) }
	it { should have_field('Username') }
	it { should have_field('Email') }
	it { should have_field('Password') }
	it { should have_field('Confirmation') }
	it { should have_button('Create my account') }
end
