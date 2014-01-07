class HashtagsController < ApplicationController
	def create
		@hashtag = current_user.hashtags.build(hashtag_params)
		if @hashtag.save
			redirect_to root_path
		else
			render 'new'
		end
	end

	def destroy
	    @hashtag = Hashtag.find(params[:id])
	    @hashtag.destroy 
	    redirect_to root_url
  	end

	def show
		@hashtag = Hashtag.find(params[:id])
	end 

	private 

	def hashtag_params 
		params.require(:hashtag).permit(:content, :user_id)
	end
end
