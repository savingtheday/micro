class FollowRelationship < ActiveRecord::Migration
  def change
    create_table :follow_relationships do |t|
      t.integer :follower_id
      t.integer :followed_id
    end
  end
end
