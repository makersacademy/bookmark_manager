# This class corresponds to a table in the database
# We can use it to manipulate the data
class Link

  # this makes the instances of this class Datamapper resources
  include DataMapper::Resource

  has n, :tags, :through => Resource

  # This block describes what resources our model will have
  # it's a good idea to have a unique id field to differentiate between
  # records with the same title and url (if it ever happens)
  property :id,     Serial # Serial means that it will be auto-incremented for every record
  property :title,  String
  property :url,    String

end