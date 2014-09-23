class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :index]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy]

  add_breadcrumb "Users", :users_path

  def new
    @user = User.new

    add_breadcrumb "Sign Up"
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
    @moderator_join = ModeratorJoin.new
    @user = User.find(params[:id])
    if signed_in?
      grantable_boards = current_user.moderating
      @available_boards = grantable_boards.delete_if { |b| @user.moderating?(b) }
    end

    @posts = @user.posts.order("created_at DESC").last(5)
    @topics = @user.topics.order("created_at DESC").last(5)

    add_breadcrumb "#{@user.username}", user_path(@user)
  end

  def user_posts
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])

    add_breadcrumb "#{@user.username}", user_path(@user)
    add_breadcrumb "User Posts", user_posts_path(@user)
  end

  def user_topics
    @user = User.find(params[:id])
    @topics = @user.topics.order("created_at DESC").paginate(page: params[:page])

    add_breadcrumb "#{@user.username}", user_path(@user)
    add_breadcrumb "User Topics", user_topics_path(@user)
  end

  def edit
    @user = User.find(params[:id])    

    add_breadcrumb "#{@user.username}", user_path(@user)
    add_breadcrumb "Settings", edit_user_path(@user)
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