class SessionsController < ApplicationController
  def new
    # 10.2.3演習No.2
    # debugger
  end

  def create
    # 9.3.1演習No.1
    # @user = User.find_by(email: params[:session][:email].downcase)
    # if @user && @user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      # log_in @user
      # params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      # redirect_to @user
    # else
      # エラーメッセージを作成する
      # flash.now[:danger] = 'Invalid email/password combination'
      # render 'new'
    # end
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        # ユーザーログイン後にユーザー情報のページにリダイレクトする
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end
    else
      # エラーメッセージを作成する
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    # 9.1.4演習No.1
    # log_out if logged_in?
    # log_out
    log_out if logged_in?
    redirect_to root_url
  end
end
