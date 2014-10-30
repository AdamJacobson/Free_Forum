describe "users/index.html.erb" do
	let!(:user) { create(:user) }

	subject { page }

	before do
		sign_in(user)
		visit users_path
	end

	it { should have_selector('td', text: user.username) }
	it { should have_title(full_title('Users')) }
	it { should have_content(user.username) }

	describe "pagination" do
		before(:all) { 30.times { create(:user) } }
		after(:all)  { User.delete_all }

		it { should have_selector('div.pagination') }

		it "should list each user" do
			User.paginate(page: 1).each do |user|
				expect(page).to have_selector('td', text: user.username)
			end
		end
	end

end