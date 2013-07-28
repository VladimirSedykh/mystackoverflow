class AnswersController < ApplicationController

  def index
    Answer.all
  end


  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(params[:answer])

    if @answer.save
      redirect_to question_path(@question)
    else
      #render :action => "show", :controller => "questions"
      render :template => "questions/show"
    end
  end
end