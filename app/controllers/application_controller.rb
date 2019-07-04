class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    if Student.find_by(id: session[:user_id])
      @current_user = Student.find_by(id: session[:user_id])
    else
      @current_user = Teacher.find_by(id: session[:user_id])
    end
  end

  def authenticate_user
    if @current_user==nil
      flash[:notice]="ログインが必要です"
      redirect_to("/login")
    end
  end

  def forbid_login_user
    if @current_user
      flash[:notice]="すでにログインしています"
      redirect_to("/")
    end
  end
  
  def user_is_teacher
    if Teacher.find_by(id: session[:user_id])
      flash[:notice]="教授は質問できません"
      redirect_to("/")
    end
  end
end
