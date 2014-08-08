class PostsController < ApplicationController
	before_action :signed_in_user, only: [:new, :create]

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
      flash[:success] = "Post Created"
      redirect_to topic_path(@topic, :page => @topic.last_page, :anchor => "post-#{@post.id}") 
    else
      render 'new'
    end
  end

  private

    def post_params
      params.require(:post).permit(:user_id, :content)
    end

end
