class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user!, only: [:edit, :update]
  before_action :admin_user!, only: :destroy

  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.page(params[:page])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, notice: t('flash.user_deleted')
  end

  def following
    @title = 'Following'
    @user = User.find(params[:id])
    @users = @user.following.page(params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page])
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # beforeフィルター

  # 正しいユーザーかどうか確認
  def correct_user!
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # 管理者かどうか確認
  def admin_user!
    redirect_to(root_url) unless current_user.admin?
  end
end
