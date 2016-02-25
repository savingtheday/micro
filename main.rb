require 'sinatra'
require 'sinatra/activerecord'

enable :sessions

set :database, "sqlite3:microblog.sqlite3"


require './models/posts'
require './models/users'

get '/' do
  current_user
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
  erb :sign_in
end

get '/sign-up-success' do
  erb :signupsuccess
end

post '/sign-up-success' do
  puts "my params" + params.inspect
  erb :signupsuccess
end


post '/sign_up' do
  erb :sign_up
end

def current_user
  if session[:user_id]
    @current_user = User.find(session[:user_id])
  end
end
