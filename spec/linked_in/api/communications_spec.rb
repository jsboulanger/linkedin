require 'helper'

describe LinkedIn::Api::Communications do
  before do
    @client = LinkedIn::Client.new('token', 'secret')
    @consumer = OAuth::Consumer.new('token', 'secret', { :site => 'https://api.linkedin.com' })
    @client.stub(:consumer).and_return(@consumer)
    @client.authorize_from_access('atoken', 'asecret')
  end

  describe "#send_message" do
    before do
      stub_request(:post, "https://api.linkedin.com/v1/people/~/mailbox").to_return(:body => "{}", :status => 201)
      @result = @client.send_message("1234abcd", "My Subject", "My body")
    end

    it "should get the correct resource" do
      a_request(:post, "https://api.linkedin.com/v1/people/~/mailbox").with(
        :headers => { "Content-Type" => "application/json" }
        ).should have_been_made
    end

    it "should pass the parameters to the request" do
      a_request(:post, "https://api.linkedin.com/v1/people/~/mailbox").with do |req|
        preq = ::MultiJson.decode(req.body)
        preq["subject"] == "My Subject" &&
          preq["body"] == "My body" &&
          preq["recipients"] == { "values" => ["person" => { "_path" => "/people/1234abcd" }] }
      end.should have_been_made
    end

    it "should return 201 created when successful" do
      @result.should == "201"
    end
  end
end
