describe "users/user_posts.html.erb_spec.rb" do
	let!(:user) { create(:user) }
	let!(:board) { create(:board) }
	let!(:topic) { create(:topic, user: create(:user), board: board) }

	subject { page }

	describe "by default" do
		before { visit user_posts_path(user) }

		it { should have_title(full_title("All Posts for #{user.username}")) }
		it { should have_content("User Posts") }
		it { should have_content("This user has no posts") }
	end

	describe "with at least 1 post" do
		let!(:post) { create(:post, user: user, topic: topic) }
		before { visit user_posts_path(user) }

		it { should have_content(post.content) }
	end


end