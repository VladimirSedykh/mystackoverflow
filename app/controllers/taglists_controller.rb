	def new
		@taglist = Taglist.new
	end

	def create
		@taglist = Taglist.new(params[:taglist])
		if @tag.save		
			redirect_to posts_path
		else
			render :action => "new"
		end
	end