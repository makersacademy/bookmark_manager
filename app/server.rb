class BookmarkManager < Sinatra::Base
  use Rack::MethodOverride
  enable :sessions
  set :session_secret, 'super secret'
  register Sinatra::Flash
  register Sinatra::Partial
  set :partial_template_engine, :erb

  enable :partial_underscores

  set :root, File.dirname(__FILE__)
  run! if app_file == $0

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end
end
