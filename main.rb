require 'sinatra'
require 'sinatra/activerecord'

enable :sessions

set :database, "sqlite3:microblog.sqlite3"


require './models/posts'
require './models/users'

get '/' do
  erb :fullprofile
end

get '/feed' do
  erb :feed
end

get '/following' do
  erb :following
end

post '/following' do
  erb :following
end

post '/sign_in' do
  @user =User.where(username: params[:username]).first
  if @user && @user.password == params[:password]
    session[:user_id] = @user.id
    redirect '/'
  else
    @message = "Incorrect Sign-in Information."
    redirect '/incorrect'
  end
end

get '/incorrect' do
  erb :incorrect
end

get '/sign_up' do
  erb :sign_up
end

get '/sign_in' do
  @users = User.all
  erb :sign_in
end

get '/sign-up-success' do
  erb :signupsuccess
end

post '/sign-up-success' do
  @user_name = params["username"]
  @user_email = params["email"]
  @user_password = params["password"]
  @user_birthday = params["birthday"]
  User.create(username: @user_name, email: @user_email, password: @user_password, birthday: @user_birthday)
  redirect '/sign_in'
end


# post '/sign_up' do
#   @user = User.create(username:, email:, password:, birthday:)
#   erb :sign_up
# end

post '/sign_up' do
  redirect '/sign-up-success'
end


get '/post_success' do
  erb :signupsuccess
end

post '/post_success' do
  puts "my params" + params.inspect
  erb :signupsuccess
end


post '/new_post' do
  erb :newpost
end

get '/new_post' do
  erb :newpost
end

get '/signout' do
    session[:user_id] = nil
    redirect to ('/sign_in')
end

def current_user
  if session[:user_id]
    @current_user = User.find(session[:user_id])
  end
end
