class Username < ActiveRecord::Base
	def self.pull_images
		popular = Instagram.media_popular.each do |data|
			Username.create!(:user_id => data.comments['data'][0]['from']["id"], :username => data.comments['data'][0]['from']['username'] )
		end
	end
end 
