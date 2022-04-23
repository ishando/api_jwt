require 'rails_helper'
require 'generate_jwt'

RSpec.describe "GenerateJwt", type: :request do
  context "create jwt" do
    let (:client) { FactoryBot.create(:client, name: 'TestClient') }

    it "produces jwt for valid client" do
      client
      token = GenerateJwt.new(client.name)
      expect(token.get_auth).to match(/^[[:alnum:]]{36}\.[[:alnum:]]{83}\.[0-9a-zA-Z_.-]{43}$/)
    end

    it "doesn't produce jwt for invalid client" do
      token = GenerateJwt.new('NotAClient')
      expect(token.get_auth).to be nil
    end

  end
end
