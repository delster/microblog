require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'sinatra/flash'
require './models'
enable :sessions

configure(:development) {set :database, 'sqlite3:microblog.sqlite3'}

def current_user
  if session[:user_id]
    @current_user = User.find(session[:user_id])
  end
end

get '/' do
  erb :home
end

get '/signup' do
  erb :signup
end

get '/login' do
  erb :login
end

get '/post/:id' do
  @post = Post.find(params[:id])
  erb :post
end

get '/posts' do
  @posts = Post.all
  erb :posts
end

get '/user/:id' do
  @user = User.find(params[:id])
  @posts = @user.posts
  erb :user
end

get '/users' do
  @users = User.all
  erb :users
end

post '/users/new' do
  User.create(params[:new_user])
  redirect "/user/#{User.last.id}"
end

post '/sign-in' do
  @user = User.where(user_name: params[:user_name]).first
  if @user.password == params[:password]
    session[:user_id] = @user.id
    flash[:notice] = 'Success!'
    redirect "/user/#{@user.id}"
  else
    flash[:notice] = 'FAILED LOGIN :('
    redirect '/sign-in-failed'
  end
end

get '/sign-in-failed' do
  erb :sign_in_failed
end
