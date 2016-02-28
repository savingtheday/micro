class User < ActiveRecord::Base
  has_many :posts

  # when they follow another user
  has_many :relationship, foreign_key: :follows_id
  has_many :followed, through: :relationships, source: :followed
  # followed by a user
  has_many :reverse_relationships, foreign_key: :follower_id, class_name: 'Relationship'
  has_many :followers, through: :reverse_relationships, source: :follower


    def get_followers

    followersArray = []
    follower_ids = Relationship.where(follows_id: self.id).pluck(:follower_id)

    follower_ids.each do |id|
      followersArray.push User.find id
    end

    return followersArray

  end
end
