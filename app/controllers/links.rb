post '/links' do
  url = params["url"]
  title = params["title"]
  tags = params["tags"].split(" ").map{|tag| Tag.first_or_create(:text => tag)}
  link = Link.create(:url => url, :title => title, :tags => tags)
  if request.xhr?
    erb :link, :locals => {:link => link}, :layout => false
  else
    redirect to('/')
  end
end

get '/links/new' do
  erb :"links/new", :layout => !request.xhr?
end