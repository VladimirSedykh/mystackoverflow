class PostsController < ApplicationController

	# GET /posts
	def index
		@posts = Post.all
		@user_posts = Post.where(user_id: current_user.id)	
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

	# DELETE /posts/1
	def destroy
    @post = Post.find(params[:id])
    if @post.destroy
    	redirect_to root_path
    end
  end

end