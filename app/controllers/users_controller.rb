class UsersController < ApplicationController
  before_filter :load_and_authorize_user, :only => [:edit, :update]
  before_filter :load_user_by_slug, :only => [:show, :user_topics, :user_comments]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Sucessfully created a new account"
      sign_in @user
      redirect_to root_url
    else
      @errors = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find_by_name_slug(params[:id])
    @topics = @user.topics.order('upvotes_count DESC LIMIT 10')
  end

  def edit
  end

  def update
    @user.update_attributes(params[:user])
    if @user.save
      flash[:success] = "User successfully updated"
      redirect_to root_url
    else
      @errors = @user.errors.full_messages
      render :edit
    end
  end

  def user_topics
  end

  def user_comments
  end

private
  def load_user_by_slug
    @user = User.find_by_name_slug(params[:id])
  end
end
