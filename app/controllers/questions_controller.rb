class QuestionsController < ApplicationController

	# GET /questions
	def index

		@questions = if params[:tab] == "my"			
			Question.my(current_user)
		elsif params[:tab] == "today"		
			Question.today
		elsif params[:tab] == "week"			
			Question.week
		elsif params[:tab] == "month"			
			Question.month
		elsif params[:tab] == "fre"			
			Question.frequent
		elsif params[:search_q] == "result"			
			Question.serach_q
		else
			Question
		end

		@questions = @questions.paginate(:page => params[:page], :per_page => 5)
		# @questions = question.by_tab(params[:tab]).by_user(user)
	end

	# GET /questions/1
  def show
    @question = Question.find(params[:id])
    @answer = Answer.new

    # get answers number of qestion :id.
    @answ_num = @question.answers.all.count

 #   binding.pry

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

	def search
		if params[:details] == 'week'
			@search = Question.search_q(params[:q]).today	
		elsif params[:details] == 'users_q'	
			@search = Question.search_q(params[:q]).my(current_user)
		else
			@search = Question.search_q(params[:q])		
		end

		respond_to do |format|
			format.html
      format.js { render :json => @search}
    end

	end

	# DELETE /questions/1
	def destroy
    @question = Question.find(params[:id])
    @question.destroy
  end

end