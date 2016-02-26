class Post < ActiveRecord::Base
  belongs_to :user

  def self.message
    self.where(["message", Time.now])
  end
end
