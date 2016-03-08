class UsersController < ApplicationController

before_action :set_user, only: [:edit, :update]

  def show # 追加
   @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    #セッションのidが編集中ページのidに一致しているか確認
    #if @user.id == session[:user_id]
    if @user == current_user
      #一致していたら、そのまま処理を進める。
    else
      #一致していなかったら、エラーを表示して、プロフィール画面に戻る。
      flash[:danger] = 'You can only edit yourself.'
      render 'show'
    end
  end
  
  def update
    if @user.update(user_params)
      # 保存に成功した場合はユーザー画面を表示
      render 'show' 
    else
      # 保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :profile, :area)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
end
