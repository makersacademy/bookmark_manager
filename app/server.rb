ENV["RACK_ENV"] ||="development"

require 'sinatra/base'
require './db/data_mapper_setup'

class BookmarkManager < Sinatra::Base
  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.new(url:   params[:url],
                    title: params[:title])
    tag  = Tag.create(name: params[:tags])
    link.tags << tag
    link.save
    redirect to('/links')
  end

  set :root, File.dirname(__FILE__)
  run! if app_file == $0
end
