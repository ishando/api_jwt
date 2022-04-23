require 'rails_helper'

RSpec.describe Admin, type: :model do
	context 'creating records' do
		let(:admin1) { FactoryBot.create(:admin) }
		let(:admin2) { FactoryBot.create(:admin) }
		let(:admin3) { FactoryBot.create(:admin, username: admin1.username) }
		let(:admin4) { FactoryBot.create(:admin, username: admin1.username.upcase) }

		it 'validated single admin user' do
			expect(admin1).to be_valid
		end

		it 'validated multiple admin users' do
			expect(admin1).to be_valid
			expect(admin2).to be_valid
			expect(admin1.username).to_not eq(admin2.username)
		end

		it 'validated duplicate admin users' do
			expect(admin1).to be_valid
			expect{ admin3 }.to raise_error(ActiveRecord::RecordInvalid)
		end

		it 'validated duplicate admin users - case insensitive' do
			expect(admin1).to be_valid
			expect{ admin4 }.to raise_error(ActiveRecord::RecordInvalid)
		end

	end
end
