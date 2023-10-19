class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    # 7.1.3演習No.1
    # debugger
  end

  def new
    # 7.1.3演習No.2
    # debugger
  end
end
