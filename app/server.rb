ENV["RACK_ENV"] ||="development"

require 'sinatra/base'
require './app/models/link'

class BookmarkManager < Sinatra::Base
  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    Link.create(url: params[:url], title: params[:title])
    redirect to('/links')
  end

  set :root, File.dirname(__FILE__)
  run! if app_file == $0
end
