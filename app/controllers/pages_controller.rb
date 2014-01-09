class PagesController < ApplicationController
  def index
  	if user_signed_in?
  		@follows = Instagram.user(current_user.uid, access_token: current_user.access_token)
  		@recent_image = Instagram.user_recent_media(current_user.uid, access_token: current_user.access_token)[0]['images']['standard_resolution']['url']
  		@client = Instagram.client(:access_token => current_user.access_token) 
      @hashtags = current_user.hashtags

      if current_user.enable_following? 
        scheduler.every '2h' do
          User.follow_users(current_user.access_token, current_user.hashtags, current_user.id)
        end

        scheduler.every '24h' do
          User.unfollow_users(current_user.access_token, current_user.id)
        end
      end
  	end 
  end 

  def about
  end

  def enable_following
  	current_user.update_attribute(:enable_following, true)
  	redirect_to root_path
  end

  def disable_following
 
  end

  private

  def user_params
	params.require(:user).permit(:enable_following)
  end
end
