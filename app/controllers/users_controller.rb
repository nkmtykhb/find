class UsersController < ApplicationController
  before_action :authenticate_user,{only:[:student,:teacher]}
  before_action :forbid_login_user,{only:[:st_new,:st_create,:login_form,:login]}
  before_action :ensure_correct_user,{only:[:st_edit,:st_update,:te_edit,:te_update]}
  def student
    if params[:search1]
      @students = Student.sc_name(params[:search1])
    elsif params[:search2]
      @students = Student.sc_school(params[:search2])
    elsif params[:search3]
      @students = Student.sc_field(params[:search3])
    else
      @students=Student.all
    end
  end

  def show
    if params[:id].to_i < 1000
      @user=Student.find_by(id: params[:id])
    else
      @user=Teacher.find_by(id: params[:id])
    end
  end

  def st_new
    @student=Student.new
  end

  def st_create
    @student=Student.new(name:params[:name],
      email:params[:email],
      field:params[:field],
      school:params[:school],
      image_name: 'default_student.jpg',
      password:params[:password]
    )
    if @student.save
      session[:user_id]=@student.id
      flash[:notice]="ユーザー登録が完了しました"
      redirect_to("/users/#{@student.id}")
    else
      render("/users/st_new")
    end
  end

  def st_edit
    @student=Student.find_by(id: params[:id])
  end

  def st_update
    @student = Student.find_by(id: params[:id])
    @student.name=params[:name]
    @student.email=params[:email]
    @student.field=params[:field]
    @student.school=params[:school]
    @student.url=params[:url]
    @student.laboratory=params[:laboratory]
    @student.message=params[:message]
    if params[:image]
      @student.image_name="#{@student.id}.jpg"
      image=params[:image]
      File.binwrite("public/user_images/#{@student.image_name}",image.read)
    end

    if @student.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@student.id}")
    else
      render("users/st_edit")
    end
  end

  def login_form
  end

  def login
    @student=Student.find_by(email: params[:email],password: params[:password])
    @teacher=Teacher.find_by(email: params[:email],password: params[:password])
    if @student
      session[:user_id]=@student.id
      flash[:notice]="ログインしました"
      redirect_to("/users/#{@student.id}")
    elsif @teacher
      session[:user_id]=@teacher.id
      flash[:notice]="ログインしました"
      redirect_to("/users/#{@teacher.id}")
    else @teacher==@student
      @error_message="メールアドレスまたはパスワードが間違っています"
      @email=params[:email]
      @password=params[:password]
      render("users/login_form")
    end
  end
  def logout
    session[:user_id]=nil
    flash[:notice]="ログアウトしました"
    redirect_to("/login")
  end

  def ensure_correct_user
    if @current_user.id!=params[:id].to_i
      flash[:notice]="権限がありません"
      redirect_to("/")
    end
  end



  def teacher
    if params[:search1]
      @teachers = Teacher.sc_name(params[:search1])
    elsif params[:search2]
      @teachers = Teacher.sc_school(params[:search2])
    elsif params[:search3]
      @teachers = Teacher.sc_field(params[:search3])
    else
      @teachers = Teacher.all
    end
  end

  def te_new
    @teacher=Teacher.new
  end

  def te_create
    @teacher=Teacher.new(name:params[:name],
      email:params[:email],
      field:params[:field],
      school:params[:school],
      image_name: 'default_teacher.jpg',
      password:params[:password]
    )
    if @teacher.save
      session[:user_id]=@teacher.id
      flash[:notice]="ユーザー登録が完了しました"
      redirect_to("/users/#{@teacher.id}")
    else
      render("/users/te_new")
    end
  end

  def te_edit
    @teacher=Teacher.find_by(id: params[:id])
  end

  def te_update
    @teacher = Teacher.find_by(id: params[:id])
    @teacher.name=params[:name]
    @teacher.email=params[:email]
    @teacher.field=params[:field]
    @teacher.school=params[:school]
    @teacher.url=params[:url]
    @teacher.laboratory=params[:laboratory]
    @teacher.equipment=params[:equipment]
    @teacher.message=params[:message]

    if params[:image]
      @teacher.image_name="#{@teacher.id}.jpg"
      image=params[:image]
      File.binwrite("public/user_images/#{@teacher.image_name}",image.read)
    end

    if @teacher.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@teacher.id}")
    else
      render("users/te_edit")
    end
  end

end
