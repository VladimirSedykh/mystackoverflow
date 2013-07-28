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

    @questions = @questions.paginate(:page => params[:page], :per_page => 4)
    # @questions = question.by_tab(params[:tab]).by_user(user)
  end

  # GET /questions/1
  def show
    @question = Question.find(params[:id])
    @answer = Answer.new

    @question_tags = @question.question_tags

    # get answers number of qestion :id.
    @answ_num = @question.answers.all.count

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

      Tag.find_all_by_id(params[:tags]).each do |tag|
        # QuestionTag.create(:question => @question, :tag => tag)
        @question.question_tags.create(:tag => tag)
      end
      redirect_to root_path

    else
      render :action => "new"
    end
  end


  # PUT /questions/1
  def edit    
    @question = Question.find(params[:id])

   @question_tags = @question.question_tags

  end

  def update
    @question = Question.find(params[:id])

    if @question.update_attributes(params[:question])

      Tag.find_all_by_id(params[:tags]).each do |tag|
         # QuestionTag.create(:question => @question, :tag => tag)
         @question.question_tags.create(:tag => tag)
      end
      redirect_to :action => :show, :id => @question.id
    else
      render 'edit'
    end
  end


  def search
    @search = Question.by_content(params[:q])
    respond_to do |format|
      format.html
         format.js { render :json => @search}
    end
  end

  def search_tag
    @search_tag = Tag.by_name(params[:q])

    respond_to do |format|
      format.js { render :json => @search_tag.to_json}
    end
  end

  # DELETE /questions/1
  def destroy
    @question = Question.find(params[:id])
    @question.destroy
  end

end