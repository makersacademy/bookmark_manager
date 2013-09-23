require 'spec_helper'

describe Link do

  context "Demonstration of how datamapper works" do

    # This is not a real test, it's simply a demonstration of how it works
    it 'should be able to be created and then retrieved from the database' do
      # In the beginning our database is empty, so there are no links
      expect(Link.count).to eq(0)
      # this creates it in the database, so it's stored on the hard drive
      Link.create(:title => "Makers Academy", :url => "http://www.makersacademy.com/")
      # So if we ask the database how many link we have, it should be 1
      expect(Link.count).to eq(1)
      # Let's get the first (and only) link from the database
      link = Link.first
      # Now it has all properties that it was saved with.
      expect(link.url).to eq("http://www.makersacademy.com/")
      expect(link.title).to eq("Makers Academy")
      # If we want to, we can destroy it
      link.destroy
      # so now we have no links in the database
      expect(Link.count).to eq(0)
    end

  end

end