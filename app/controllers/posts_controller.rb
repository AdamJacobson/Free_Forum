class PostsController < ApplicationController
	before_action :signed_in_user, only: [:new, :create]

  # Post are not displayed on their own. Showing one will jump to the post inside its topic
  def show
    post = Post.find(params[:id])
    redirect_to topic_path(post.topic, :page => post.page, :anchor => post.anchor)
    # redirect_to post.permalink
  end

  def index
    @topic = Topic.find(params[:topic_id])
    redirect_to @topic
  end

  def new
  	@topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params.merge({user_id: current_user.id}))

    if @post.save
      redirect_to topic_path(@topic, :page => @post.page, :anchor => @post.anchor) 
      # redirect_to @post.permalink
    else
      render 'new'
    end
  end

  private

    def post_params
      params.require(:post).permit(:content)
    end

end
