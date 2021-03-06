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

get '/logout' do
  session.clear
  redirect '/'
end

get '/post/:id' do
  @post = Post.find(params[:id])
  @author = User.find_by(id: @post.user_id)
  if @author.nil?
    @author = User.new
    @author.nickname = '[DELETED USER]'
    @author.bg_color = 'white'
    @author.font_color = 'black'
  end
  erb :post
end

get '/posts' do
  @posts = Post.all
  erb :posts
end

post '/posts/new' do
  np_title = params['newpost-title']
  np_content = params['newpost-content']
  np_userid = current_user.id
  Post.create(title: np_title, content: np_content, user_id: np_userid)
  redirect "/post/#{Post.last.id}"
end

post '/post/update/:id' do
  @post = Post.find(params['id'])

  # Check if the editor is the owner of the account.
  if current_user.id == @post.user_id
    # Prep the meta fields for the db.
    @update_meta = params
    # Delete trash fields that come in through the form.
    @update_meta.delete('captures')
    @update_meta.delete('id')
    # Submit the update to the database.
    @post.update(@update_meta)
  end

end

get '/post/delete/:id' do
  @post = Post.find(params[:id])
  if current_user == User.find_by(id: @post.user_id)
    @post.destroy
  end
  redirect "/user/#{current_user.id}"
end

get '/user/:id' do
  @user = User.find(params[:id])
  @posts = @user.posts
  erb :user
end

post '/user/update/:id' do
  @user = User.find(params['id'])

  # Check if the editor is the owner of the account.
  if current_user.id == @user.id
    # Prep the meta fields for the db.
    @update_meta = params
    # Delete trash fields that come in through the form.
    @update_meta.delete('captures')
    @update_meta.delete('id')
    # Submit the update to the database.
    @user.update(@update_meta)
  end

end

get '/user/delete/:id' do
  @user = User.find(params['id'])
  # Only let the owner of the account delete it.
  if current_user && current_user.id == @user.id
    @user.destroy
    session.clear
    # TODO: Should we delete posts authored by this person?
  end
  redirect '/'
end

get '/users' do
  @users = User.all
  erb :users
end

post '/users/new' do
  User.create(params[:new_user])
  session[:user_id] = User.last.id
  redirect "/user/#{User.last.id}"
end

post '/sign-in' do
  @user = User.where(user_name: params[:user_name]).first
  if @user.password == params[:password]
    session[:user_id] = @user.id
    redirect "/user/#{@user.id}"
    end
    redirect '/'
end
