require 'rails_helper'

RSpec.describe Client, type: :model do

  context "creating a record" do
    let(:client1) { FactoryGirl.create(:client) }
    let(:client2) { FactoryGirl.create(:client) }
    let(:client3) { FactoryGirl.create(:client, name: client1.name) }

    it "validates single record" do
      expect(client1).to be_valid
    end

    it "validates multiple unique records" do
      expect(client1).to be_valid
      expect(client2).to be_valid
    end

    it "validates multiple non-unique records" do
      expect(client1).to be_valid
      expect{client3}.to raise_error(ActiveRecord::RecordInvalid)
    end

  end

end
