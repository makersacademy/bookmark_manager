post '/links' do
  url = params["url"]
  title = params["title"]
  tags = params["tags"].split(" ").map{|tag| Tag.first_or_create(:text => tag)}
  Link.create(:url => url, :title => title, :tags => tags)
  redirect to('/')
end

get '/links/new' do
  erb :"links/new", :layout => !request.xhr?
end