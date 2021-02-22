class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  def set_current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  def authenticate_user
    # 現在ログイン中のユーザが存在しない場合、ログインページにリダイレクトさせる。
    if @current_user == nil
      flash[:notice] = 'ログインできませんでした'
      redirect_to new_session_path
    end
  end
end


