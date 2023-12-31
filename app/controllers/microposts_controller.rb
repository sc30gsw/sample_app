class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      # 13.3.5演習No.1 有効な送信
      # flash[:success] = "Micropost created!"
      # redirect_to root_url
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    # 13.3.5演習No.1 投稿を削除する
    # @micropost.destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    # redirect_to request.referrer || root_url
    # 13.3.4演習No.2
    redirect_back(fallback_location: root_url)
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
