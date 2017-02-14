require 'spec_helper'

describe 'GET /api/tasks/:id' do
  let(:user) { create(:user) }
  let(:access_token) { create(:access_token, resource_owner_id: user.id) }
  let(:task) { create(:task, user: user) }
  let(:request_params) {
    {
      access_token: access_token.token
    }
  }

  context 'returns a task by :id' do
    before do
      get "/api/tasks/#{task.id}", params: request_params
    end

    it 'returns a task by :id' do
      expect(json).to eq(
        {
          'id'            => task.id,
          'title'         => task.title,
          'description'   => task.description,
          'priority'      => task.priority,
          'due_date'      => task.due_date,
          'completed'     => task.completed,
          'created_at'    => task.created_at.as_json,
          'updated_at'    => task.updated_at.as_json
        }
      )
    end
  end
end
