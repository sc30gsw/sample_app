class UsersController < ApplicationController

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
      flash[:success] = "Welcome to the Sample App!"
      # 7.4.4演習No.3
      redirect_to @user
      # 7.4.1演習No.2
      # redirect_to user_url(@user)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
