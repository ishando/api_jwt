require 'rails_helper'

RSpec.describe "Authenticates", type: :request do
  context "POST authenticates" do
    let(:post_header) { { 'Content-Type': 'application/json' } }
    let(:appl) { FactoryGirl.create(:app) }
    let(:data) { appl.name }

    it "posts app name to get jwt" do
      appl
      puts "Data: #{data}"
      post '/authenticate', params: { name: data }.to_json, headers: post_header
      puts "Response: #{response.inspect}"
      expect(response).to have_http_status(200)
    end
  end
end
