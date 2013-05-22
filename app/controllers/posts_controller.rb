class PostsController < ApplicationController

	def index
		@posts = Post.all
	end

	def new
		@post = Post.new
	end

	def create
		@post = current_user.posts.build(params[:post])
		if @post.save
			redirect_to root_path
		else
			render :action => "new"
		end
	end

	def destroy
    @post = Post.find(params[:id])
    @post.destroy
  end

end