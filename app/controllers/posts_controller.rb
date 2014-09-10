class PostsController < ApplicationController
	before_action :signed_in_user, only: [:new, :create, :update, :edit]
  before_action :can_post,       only: [:new, :create, :update, :edit]
  before_action :correct_user,   only: [:edit, :update]

  add_breadcrumb "Forums", :boards_path

  # Post are not displayed on their own. Showing one will jump to the post inside its topic
  def show
    post = Post.find(params[:id])
    redirect_to post.permalink
  end

  def edit
    @post = Post.find(params[:id])

    add_breadcrumb "#{@post.topic.board.title}", @post.topic.board
    add_breadcrumb "#{@post.topic.title.truncate(40, separator: ' ')}", @post.topic
    add_breadcrumb "Edit Post"
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

    add_breadcrumb "#{@post.topic.board.title}", @post.topic.board
    add_breadcrumb "#{@post.topic.title.truncate(40, separator: ' ')}", @post.topic
    add_breadcrumb "New Post"
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

    # Determine if user can post
    def can_post
      if (params[:topic_id]).nil?
        topic = Post.find(params[:id]).topic
      else
        topic = Topic.find(params[:topic_id])
      end

      # Only moderators and admins can post in locked topics
      if topic.locked? && !current_user_is_admin?
        flash[:alert] = "That topic is currently locked." 
        redirect_to(topic)
      end
    end

end
