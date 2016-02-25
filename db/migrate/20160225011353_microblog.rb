class Microblog < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password
      t.datetime :birthday, default: Time.now
    end
  end
end
