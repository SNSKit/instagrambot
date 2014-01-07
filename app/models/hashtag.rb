class Hashtag < ActiveRecord::Base
	belongs_to :user

	attr_accessible :content
end
