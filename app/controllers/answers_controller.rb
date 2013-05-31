class AnswersController < ApplicationController

	def index
		Answer.all
	end

	def new
		@answer = Answer.new
	end

	def create
		@answer = Answer.new(params[:answer])
		if @answer.save
			redirect_to root_path
		else
			render :action => "new"
		end
	end