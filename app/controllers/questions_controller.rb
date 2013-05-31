class QuestionsController < ApplicationController

	# GET /questions
	def index

		@questions = if params[:tab] == "all"
			Question.all					
		elsif params[:tab] == "my"			
			Question.my(current_user)
		elsif params[:tab] == "today"		
			Question.today
		elsif params[:tab] == "week"			
			Question.week
		elsif params[:tab] == "month"			
			Question.month
		elsif params[:tab] == "fre"			
			Question.frequent
		else
			Question.all				
		end

		# @questions = question.by_tab(params[:tab]).by_user(user)
	end

	# GET /questions/1
  def show
    @question = Question.find(params[:id])
    @answer = Answer.new

    @question.update_attributes!(
   		:view => Question.counter(params[:id])
		)
  end

	# GET /questions/new
	def new
		@question = Question.new
		@all_tags = Tag.all
	end

	# question /questions
	def create
		@question = current_user.questions.build(params[:question])
		if @question.save
			redirect_to root_path
		else
			render :action => "new"
		end
	end


	# PUT /questions/1
  def edit
  	@question = Question.find(params[:id])
	end

	def update
	  @question = Question.find(params[:id])
	 
	  if @question.update_attributes(params[:question])
	    redirect_to :action => :show, :id => @question.id
	  else
	    render 'edit'
	  end
	end

	# DELETE /questions/1
	def destroy
    @question = Question.find(params[:id])
    if @question.destroy
    	redirect_to root_path
    end
  end

end