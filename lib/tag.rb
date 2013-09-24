class Tag

  include DataMapper::Resource

  belongs_to :link

  property :id, Serial
  property :text, String
  
end