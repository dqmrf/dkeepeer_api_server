require 'spec_helper'

RSpec.describe Task, type: :model do
  describe 'assosiations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    subject { FactoryGirl.create(:task) }

    before(:each) do
      @task_model = Task.new
    end

    context 'valid' do
      it { should validate_presence_of(:title) }
      it { should validate_presence_of(:priority) }
      it { should validate_numericality_of(:priority) }
      it { should validate_presence_of(:due_date) }
      it { @task_model.due_date_cannot_be_in_the_past }
    end
  end
end
