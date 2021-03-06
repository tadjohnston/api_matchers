require 'spec_helper'

RSpec.describe APIMatchers::Headers::BeJSON do
  describe "actual.to be_json" do
    it "should pass when the actual is json response" do
      expect("application/json; charset=utf-8").to be_json
    end

    it "should not pass when the actual is not a json response" do
      expect {
        expect("application/xml; charset=utf-8").to be_json
      }.to fail_with(%Q{expected a JSON response with 'application/json; charset=utf-8'. Got: 'application/xml; charset=utf-8'.})
    end
  end

  describe "actual.not_to be_json" do
    it "should pass when the actual is not a json response" do
      expect("application/xml; charset=utf-8").not_to be_json
    end

    it "should not pass when the actual is a json response" do
      expect{
        expect("application/json; charset=utf-8").not_to be_json
      }.to fail_with(%Q{expected to not be a JSON response. Got: 'application/json; charset=utf-8'.})
    end
  end

  describe "with change configuration" do
    before do
      APIMatchers.setup do |config|
        config.header_method = :response_header
        config.header_content_type_key = 'Content-Type'
      end
    end

    after do
      APIMatchers.setup do |config|
        config.header_method = nil
        config.header_content_type_key = nil
      end
    end

    it "should pass if the actual.response_header is equal to application/json" do
      response = OpenStruct.new(:response_header => { 'Content-Type' => "application/json; charset=utf-8"})
      expect(response).to be_json
    end

    it "should fail if the actual.response_header is not equal to application/json" do
      response = OpenStruct.new(:response_header => { "Content-Type" => "application/xml; charset=utf-8"})
      expect {
        expect(response).to be_json
      }.to fail_with(%Q{expected a JSON response with 'application/json; charset=utf-8'. Got: 'application/xml; charset=utf-8'.})
    end

    it "should fail if the actual.response_header is not equal to application/json" do
      response = OpenStruct.new(:response_header => { "foo-bar" => "application/xml; charset=utf-8"})
      expect {
        expect(response).to be_json
      }.to fail_with(%Q{expected a JSON response with 'application/json; charset=utf-8'. Got: '{"foo-bar"=>"application/xml; charset=utf-8"}'.})
    end
  end
end