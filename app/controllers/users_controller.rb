class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :index]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "New user created."
      redirect_to @user
    else
    	render 'new'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
  	@user = User.find(params[:id])
    @posts = @user.posts.order("created_at DESC").last(5)
    @topics = @user.topics.order("created_at DESC").last(5)
  end

  def user_posts
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
  end

  def user_topics
    @user = User.find(params[:id])
    @topics = @user.topics.order("created_at DESC").paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.email = params[:user][:email]
    if @user.save
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # def destroy
  #   User.find(params[:id]).destroy
  #   flash[:success] = "User deleted."
  #   redirect_to users_url
  # end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

    # Before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
  end