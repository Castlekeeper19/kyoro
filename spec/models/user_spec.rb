require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'ensures email presence' do
      user = User.new(name: 'Sample Name', password: '123123').save
      expect(user).to eq(false)
    end

    it 'ensures password presence' do
      user = User.new(name: 'Sample Name', email: 'SampleEmail@email.com').save
      expect(user).to eq(false)
    end

    it 'should save successfully' do
      user = User.new(name: 'Sample Name', email: 'SampleEmail@email.com', password: '123123').save
      expect(user).to eq(true)
    end
  end

  context 'scope tests' do
    # let (:params) { { name: 'Sample Name', email: 'SampleEmail@email.com', password: '123123' } }
    before(:each) do
      User.new(name: 'Sample Name', email: 'SampleEmail@email.com', password: '123123').save
      User.new(name: 'Sample Name', email: 'SampleEmail2@email.com', password: '123123').save
      User.new(name: 'Sample Name', email: 'SampleEmail3@email.com', password: '123123', admin: true).save
    end

    it 'should return admin users' do
      expect(User.admin_users.count).to eq(1)
    end

    it 'should return non-admin users' do
      expect(User.nonadmin_users.count).to eq(2)
    end
  end
end
