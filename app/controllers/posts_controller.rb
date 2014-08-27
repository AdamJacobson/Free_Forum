class PostsController < ApplicationController
	before_action :signed_in_user, only: [:new, :create]
  before_action :correct_user,   only: [:edit, :update]

  # Post are not displayed on their own. Showing one will jump to the post inside its topic
  def show
    post = Post.find(params[:id])
    redirect_to post.permalink
  end

  def index
    @topic = Topic.find(params[:topic_id])
    redirect_to @topic
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "Post updated"
      redirect_to @post.permalink
    else
      render 'edit'
    end
  end

  def new
  	@topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params.merge({user_id: current_user.id}))

    if @post.save
      redirect_to @post.permalink
    else
      render 'new'
    end
  end

  private

    def post_params
      params.require(:post).permit(:content)
    end

    # Before filters

    def correct_user
      @user = Post.find(params[:id]).user
      redirect_to(root_url) unless current_user?(@user)
    end

end
