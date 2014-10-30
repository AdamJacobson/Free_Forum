describe "users/edit.html.erb" do
	let!(:user) { create(:user) }

	subject { page }

	before do
		sign_in(user)
		visit edit_user_path(user)
	end

	it { should have_content("Settings") }
	it { should have_title(full_title("Settings")) }
	it { should have_field("Email") }
	it { should have_button("Save changes") }
end