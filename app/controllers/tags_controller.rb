class TagsController < ApplicationController

  # GET /posts
  def index
    @tags = Tag.all
  end

	# GET /posts/1
  def show
    @tag = Tag.find(params[:id])
  end

  # GET /posts/new
  def new
    @tag = Tag.new
  end

  # POST /posts
  def create
    @tag = Tag.new(params[:tag])
    if @tag.save		
      flash[:success] = "Tag created!"	
      redirect_to tags_path
    else
      render :action => "new"
    end
  end

  # DELETE /posts/1
  def destroy
    @tag = Tag.find(params[:id])
    if @tag.destroy
      redirect_to tags_path
    end
  end

end