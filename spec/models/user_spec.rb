require "rails_helper"

RSpec.describe User, type: :model do
  describe 'assosiations' do
    it { should have_many(:tasks) }
  end

  describe 'validations' do
    subject { FactoryGirl.build(:user) }

    context 'valid' do
      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email) }
      it { should validate_presence_of(:first_name) }
      it { should validate_presence_of(:last_name) }
    end
  end
end
