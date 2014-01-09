class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  attr_accessible :enable_following 
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:instagram]

  has_many :hashtags

  has_many :follows

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user| 
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
      user.access_token = auth.credentials.token
      user.picture = auth.info.image
    end
  end
  
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new session["devise.user_attributes"] do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def self.follow_users(token, tags, user_id)
    tags.each do |hashtag|
      Instagram.tag_recent_media(hashtag.content).data.each do |data|
        Instagram.follow_user(data.user.id, :access_token => token).each do 
          Follow.create!(
            user_id: user_id,
            followed_id: data.user.id.to_s
          )
          Instagram.user_recent_media(data.user.id, :count => "4").each do |image|
            Instagram.like_media(image.id, :access_token => token)
          end
        end
      end
    end
  end

  def self.unfollow_users(access_token, user_id)
    follows = User.find(user_id).follows.where('created_at > ?', 3.days.ago)
    follows.each do |follow|
     Instagram.unfollow_user(follow.followed_id, :access_token => access_token)
    end
  end
  
  def password_required?
    super && provider.blank?
  end

  def email_required?
  	super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
end
