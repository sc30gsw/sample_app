class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]

  # 10.2.1演習No.1
  # before_action :logged_in_user
  # only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    # 7.1.3演習No.1
    # debugger
  end

  def new
    @user = User.new
  end

  def create
    # 7.1.3演習No.2
    # debugger
    @user = User.new(user_params)
    if @user.save
      # 8.2.5演習No.1
      # log_in @user
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      # 7.4.4演習No.3
      redirect_to @user
      # 7.4.1演習No.2
      # redirect_to user_url(@user)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
end
