require 'sinatra'
require 'sinatra/activerecord'



set :database, "sqlite3:microblog.sqlite3"


require './models/posts'
require './models/users'
