require 'data_mapper'
require 'dm-postgres-adapter'

require_relative '../app/models/tag'
require_relative '../app/models/user'
require_relative '../app/models/link'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!
