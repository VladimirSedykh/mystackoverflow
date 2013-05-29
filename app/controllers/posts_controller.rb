class PostsController < ApplicationController

	# GET /posts
	def index

		if params[:tab] == "all"
			@posts = Post.all					
		elsif params[:tab] == "my"			
			@posts = Post.my(current_user)
		elsif params[:tab] == "today"		
			@posts = Post.today
		elsif params[:tab] == "week"			
			@posts = Post.week
		elsif params[:tab] == "month"			
			@posts = Post.month
		else
			@posts = Post.all				
		end

		# @posts = Post.by_tab(params[:tab]).by_user(user)
	end

	# GET /posts/1
  def show
    @post = Post.find(params[:id])

    @post.update_attributes!(
   		:view => Post.counter(params[:id])
		)
  end

	# GET /posts/new
	def new
		@post = Post.new
		@all_tags = Tag.all
	end

	# POST /posts
	def create
		@post = current_user.posts.build(params[:post])
		if @post.save
			redirect_to root_path
		else
			render :action => "new"
		end
	end


	# PUT /posts/1
  def edit
  	@post = Post.find(params[:id])
	end

	def update
	  @post = Post.find(params[:id])
	 
	  if @post.update_attributes(params[:post])
	    redirect_to :action => :show, :id => @post.id
	  else
	    render 'edit'
	  end
	end

	# DELETE /posts/1
	def destroy
    @post = Post.find(params[:id])
    if @post.destroy
    	redirect_to root_path
    end
  end

end