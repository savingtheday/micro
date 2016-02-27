class Relationship < ActiveRecord::Migration
  def change
    create_table :relationship do |t|
      t.integer :follows_id
      t.integer :follower_id
    end
  end
end
