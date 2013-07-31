class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params) #extremely dangerous - throws error when working with Rails 4.0
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      sign_in(@user)
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
  # new way to permit only listed attributes for user params
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Before filters
  def signed_in_user
    redirect_to signin_url, notice: "Please sign in." unless signed_in?
  end

end
