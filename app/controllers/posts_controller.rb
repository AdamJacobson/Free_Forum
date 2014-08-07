class PostsController < ApplicationController
	before_action :signed_in_user, only: [:new, :create]

  def new
  	@topic = Topic.find(params[:id])
    @post = Post.new
  end

  def create
    @topic = Topic.find(params[:id])
    @post = @topic.posts.build(post_params.merge({user_id: current_user.id}))

    if @post.save
      flash[:success] = "Post Created"
      redirect_to topic_path(@topic, :page => @topic.last_page, :anchor => "post-#{@post.id}") 
    else
      render 'new'
    end
  end

  def destroy
  end

  def edit
  end

  private

    def post_params
      params.require(:post).permit(:content)
    end

end
