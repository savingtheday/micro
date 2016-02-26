class Post < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.text :message
      t.datetime :posted, default: Time.now
    end
  end
end

