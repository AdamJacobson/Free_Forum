class PostsController < ApplicationController
  before_action :correct_user,     only: [:edit, :update]
  before_action :check_permission, only: [:new, :create, :update, :edit]

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
      unless current_user?(@user)
        redirect_to root_url
        flash[:alert] = "You do not have permission to do that."
      end
    end

    # Determine if user can post
    def check_permission
      # Check if user is signed in
      signed_in_user
      
      if (params[:topic_id]).nil?
        topic = Post.find(params[:id]).topic
      else
        topic = Topic.find(params[:topic_id])
      end

      # Admins have unlimited power
      if !current_user_is_admin?
        # Moderators have unlimited power in their boards
        if !current_user_is_moderator?(topic.board)

          # Check that user has the required rank to post in the board
          if !topic.board.required_rank.nil?
            req_rank = Rank.find(topic.board.required_rank)
            unless current_user.rank >= req_rank
              flash[:alert] = "You do not have the required rank for that board." 
              redirect_to topic
              return
            end
          end

          # Check if the board is unlocked
          if topic.board.locked?
            flash[:alert] = "That board is currently locked."
            redirect_to topic
            return
          end

          # Check if the topic is unlocked
          if topic.locked?
            flash[:alert] = "That topic is currently locked." 
            redirect_to topic
            return
          end
        end
      end
    end
    
end
