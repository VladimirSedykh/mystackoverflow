class PostsController < ApplicationController

	# GET /posts
	def index

		if params[:tab] == "all"
			@posts = Post.all					
		elsif params[:tab] == "my"			
			@posts = Post.where(id: current_user.id)
		elsif params[:tab] == "today"			
			@posts = Post.find(:all, :conditions => {:created_at => 1.day.ago..Time.now})
		elsif params[:tab] == "week"			
			@posts = Post.find(:all, :conditions => {:created_at => 1.week.ago..Time.now})
		elsif params[:tab] == "month"			
			@posts = Post.find(:all, :conditions => {:created_at => 1.month.ago..Time.now})
		else
			@posts = Post.all				
		end
	end

	# GET /posts/1
  def show
    @post = Post.find(params[:id])
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
  def update
    @post = Post.find(params[:id])
    @all_tags = Tag.all

	 	if @post.update_attributes(params[:post])
	    redirect_to(@post)
	  else
	    render "edit"
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