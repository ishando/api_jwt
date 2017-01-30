require 'rails_helper'

RSpec.describe App, type: :model do

  context "creating a record" do
    let(:app1) { FactoryGirl.create(:app) }
    let(:app2) { FactoryGirl.create(:app) }
    let(:app3) { FactoryGirl.create(:app, name: app1.name) }

    it "validates single record" do
      expect(app1).to be_valid
    end

    it "validates multiple unique records" do
      expect(app1).to be_valid
      expect(app2).to be_valid
    end

    it "validates multiple non-unique records" do
      expect(app1).to be_valid
      expect{app3}.to raise_error(ActiveRecord::RecordInvalid)
    end

  end

end
