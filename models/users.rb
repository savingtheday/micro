class User < ActiveRecord::Base
  has_many :posts

  has_many :active_relationships, class_name: "FollowRelationship", foreign_key: :follower_id, dependent: :destroy

  has_many :passive_relationships, class_name: "FollowRelationship", foreign_key: :followed_id, dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  #   def get_followers

  #   followersArray = []
  #   follower_ids = Relationship.where(follows_id: self.id).pluck(:follower_id)

  #   follower_ids.each do |id|
  #     followersArray.push User.find id
  #   end

  #   return followersArray

  # end
end
