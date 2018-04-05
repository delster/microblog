require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'sinatra/flash'
require './models'
enable :sessions

set :database, "sqlite3:microblog.sqlite3"

def current_user
    if session[:user_id]
        @current_user = User.find(session[:user_id])
    end
end

get '/' do
    erb :home
end

get '/about' do
    erb :about
end

get '/users' do
    @users = User.all
    erb :users
end

get '/user/:id' do
    @user = User.find(params[:id])
    @posts = @user.posts
    erb :user
end

post '/users/new' do
    puts "****************************"
    puts params
    puts "****************************"
    User.create(params[:post])
    redirect '/users'
end

post '/sign-in' do
    @user = User.where(fname: params[:fname]).first
    if @user.password == params[:password]
        session[:user_id] = @user.id
        flash[:notice] = "Success!"
        redirect '/'
    else
        flash[:notice] = "FAILED LOGIN :("
        redirect '/sign-in-failed'
    end
end

get '/sign-in-failed' do
    erb :sign_in_failed
end
