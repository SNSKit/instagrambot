class Follow < ActiveRecord::Base
	attr_accessible :user_id, :followed_id
end