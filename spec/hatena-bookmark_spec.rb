require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Hatena::Bookmark do

  before do
    @hatebu = Hatena::Bookmark.new(
      consumer_key:    '',
      consumer_secret: '',
      request_token:   '',
      request_secret:  ''
      )

    @sample_url = "http://www.example.com/"
    @eid = ""
  end

  it "must recieve response" do
    @hatebu.ping.should be_kind_of Hash
    @hatebu.ok?.should be_true
  end

  it "should be Hash" do
    @hatebu.feed.should be_kind_of Hash
    @hatebu.ok?.should be_true
  end

  it "create new bookmark" do
    @hatebu.create(:url => @sample_url, :comment => "test")
    .should be_kind_of Hash
    @hatebu.ok?.should be_true
  end

  it "GET /atom/edit/XXXX" do
    @hatebu.get_edit(:eid => @eid).should be_kind_of Hash
    @hatebu.ok?.should be_true
  end

  it "PUT /atom/edit/XXXX" do
    @hatebu.put_edit(:eid => @eid, :comment => "test").should be_kind_of Hash
    @hatebu.ok?.should be_true
  end

  it "DELETE /atom/edit/XXXX" do
    @hatebu.delete_edit(:eid => @eid)
    @hatebu.ok?.should be_true
  end
end
