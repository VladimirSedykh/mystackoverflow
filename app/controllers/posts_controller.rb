class PostsController < ApplicationController

	# GET /posts
	def index
		@posts = Post.all
	end

	# GET /posts/1
  def show
    @post = Post.find(params[:id])
  end

	# GET /posts/new
	def new
		@post = Post.new
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
    @post.destroy
  end

end