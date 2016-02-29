require 'sinatra'
require 'sinatra/activerecord'

enable :sessions

set :database, "sqlite3:microblog.sqlite3"


require './models/posts'
require './models/users'
require './models/followrelationships'


################### GETS ################
get '/' do
  @users = User.all
  erb :home
end

get '/change_profile' do
  erb :change
end

get '/change-profile-success' do
  erb :profilesuccess
end

get '/delete' do
  current_user
  @current_user.destroy
  redirect '/signout'
end

get '/feed' do
  blogs
  erb :feed
end

get '/followers' do
  @users = User.all
  erb :followers
end

get '/fullprofile' do
  current_user
  @user_id = current_user.id
  @post = Post.where(user_id: @user_id)
  erb :fullprofile
end

get '/incorrect' do
  erb :incorrect
end

get '/new_post' do
  erb :newpost
end

get '/post_success' do
  erb :postsuccess
end

get '/profile' do
  erb :profile
end

get '/sign_in' do
  @users = User.all
  erb :sign_in
end

get '/signout' do
    session[:user_id] = nil
    redirect to ('/sign_in')
end

get '/sign_up' do
  erb :sign_up
end


get '/sign-up-success' do
  erb :signupsuccess
end



############## POSTS ############
post '/' do
  @user =User.where(username: params[:username]).first
  if @user && @user.password == params[:password]
    session[:user_id] = @user.id
    redirect '/fullprofile'
  else
    @message = "Incorrect Sign-in Information."
    redirect '/incorrect'
  end
end

post '/change_profile' do
  redirect '/change-profile-success'
end

post '/change-profile-success' do
  current_user
  @user_name = params[:username]
  @user_email = params[:email]
  @user_password = params[:password]
  @user_birthday = params[:birthday]
  @current_user.update(username: @user_name, email: @user_email, password: @user_password, birthday: @user_birthday)
  redirect '/fullprofile'
end

post '/feed' do
  erb :feed
end

get '/follow/:id' do
  puts params.inspect
  @relationship = FollowRelationship.new(follower_id: current_user.id, followed_id: params[:id])
  erb :followers
end

post '/new_post' do
  erb :newpost
end

post '/post_success' do
  @user_id = current_user.id
  @new_post = params[:message]
  Post.create(message: @new_post, user_id: @user_id, posted: Time.now)
  redirect '/feed'
end



post '/sign_in' do
  @user =User.where(username: params[:username]).first
  if @user && @user.password == params[:password]
    session[:user_id] = @user.id
    redirect '/fullprofile'
  else
    @message = "Incorrect Sign-in Information."
    redirect '/incorrect'
  end
end

post '/sign_up' do
  redirect '/sign-up-success'
end

post '/sign-up-success' do
  @user_name = params["username"]
  @user_email = params["email"]
  @user_password = params["password"]
  @user_birthday = params["birthday"]
  User.create(username: @user_name, email: @user_email, password: @user_password, birthday: @user_birthday)
  redirect '/'
end



###### HELPERS #######


def blogs
  @posts = Post.all
end

def current_user
  if session[:user_id]
    @current_user = User.find(session[:user_id])
  end
end
