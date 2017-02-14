require "rails_helper"

RSpec.describe User, type: :model do
  describe 'assosiations' do
    it { should have_many(:tasks) }
  end
end
