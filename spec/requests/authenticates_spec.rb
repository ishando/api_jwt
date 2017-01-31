require 'rails_helper'

RSpec.describe "Authenticates", type: :request do
  context "POST authenticates" do
    let(:post_header) { { 'Content-Type': 'application/json' } }
    let(:client1) { FactoryGirl.create(:client) }
    let(:client2) { FactoryGirl.create(:client) }

    it "jwt generated for client" do
      post '/authenticate', params: { name: client1.name }.to_json, headers: post_header
      puts "Response: #{response.body.inspect}"
      expect(response).to have_http_status(200)
      expect(response.body).to match(/^\{"auth_token":"[[:alnum:]]{36}\.[[:alnum:]]{83}\.[0-9a-zA-Z_.-]{43}"\}$/)
    end

    it "different jwts generated for different clients" do
      post '/authenticate', params: { name: client1.name }.to_json, headers: post_header
      jwt1 = response.body
      post '/authenticate', params: { name: client2.name }.to_json, headers: post_header
      jwt2 = response.body
      puts "Response: #{response.body.inspect}"
      expect(response).to have_http_status(200)
      expect(response.body).to match(/^\{"auth_token":"[[:alnum:]]{36}\.[[:alnum:]]{83}\.[0-9a-zA-Z_.-]{43}"\}$/)
      expect(jwt2).to_not eq(jwt1)
    end

  end
end
