class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :user_is_teacher,{only:[:qs_new,:qs_create]}
  def index
    @questions = Question.all.order(created_at: :desc)
  end

  def qs_new
    @question=Question.new
  end

  def qs_create
    @question=Question.new(
      student_id: @current_user.id,
      content:params[:content]
    )
    if params[:image]
      @question.image_name="#{@question.id}.jpg"
      image=params[:image]
      File.binwrite("public/question_images/#{@question.image_name}",image.read)
    end

    if @question.save
      redirect_to("/posts/index")
    else
      render("/posts/question")
    end
  end

  def as_create
    @question=Question.find_by(id: params[:id])
    @answer=Answer.new(
      teacher_id: @current_user.id,
      question_id: @question.id,
      content:params[:content]
    )
    if @answer.save
      redirect_to("/posts/#{params[:id]}")
    else
      render("/posts/#{params[:id]}")
    end
  end

  def show
    @question=Question.find_by(id: params[:id])
    @answers=Answer.where(question_id: params[:id]).order(created_at: :desc)
  end

end
