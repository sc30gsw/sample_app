class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  # 10.4.3演習No.1
  # before_action :admin_user, only: :destroy
  before_action :admin_user, only: :destroy

  def index
    # 11.3.3演習No.2
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  # 10.2.1演習No.1
  # before_action :logged_in_user
  # only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    # 7.1.3演習No.1
    # debugger
    # 11.3.3演習No.2
    redirect_to root_url and return unless @user.activated?
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
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
      # 7.4.4演習No.3
      # redirect_to @user
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

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

    def user_params
      # params.require(:user).permit(:name, :email, :password, :password_confirmation)
      # 10.4.1演習No.1
      # params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # 管理者かどうか確認
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
