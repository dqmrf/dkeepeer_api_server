require 'spec_helper'

describe 'GET /api/tasks/:id' do
  include_context :doorkeeper_app_with_token
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
          'due_date'      => task.due_date.strftime("%Y-%m-%d"),
          'completed'     => task.completed,
          'user_id'       => task.user_id,
          'created_at'    => task.created_at.as_json,
          'updated_at'    => task.updated_at.as_json,
        }
      )
    end
  end

  context 'authentication failed' do
    let(:request_params) {
      {
        access_token: ''
      }
    }

    before do
      get "/api/tasks/#{task.id}", params: request_params
    end

    it { expect(response.body).to eq '{"error":"Not authorized"}' }
    it { expect(response.headers["WWW-Authenticate"]).to eq %(Bearer realm="Doorkeeper", error="invalid_token", error_description="The access token is invalid") }
  end

  context 'invalid task id' do
    let(:task_2) { FactoryGirl.create(:task) }

    it {
      expect {
        get "/api/tasks/#{task_2.id}", params: request_params
      }.to raise_error ActiveRecord::RecordNotFound
    }
  end
end

describe 'GET /api/tasks' do
  include_context :doorkeeper_app_with_token
  let!(:task_1) { create(:task, user: user) }
  let!(:task_2) { create(:task, user: user) }

  before do
    get '/api/tasks', params: { access_token: access_token.token }
  end

  it 'retrives all tasks' do
    expect(json['tasks']).to eq([
      {
        'id'          => task_2.id,
        'title'       => task_2.title,
        'priority'    => task_2.priority,
        'due_date'    => task_2.due_date.strftime("%Y-%m-%d"),
        'completed'   => task_2.completed,
        'created_at'  => task_2.created_at.as_json,
        'updated_at'  => task_2.updated_at.as_json,
        'user_id'     => task_2.user_id
      },
      {
        'id'          => task_1.id,
        'title'       => task_1.title,
        'priority'    => task_1.priority,
        'due_date'    => task_1.due_date.strftime("%Y-%m-%d"),
        'completed'   => task_1.completed,
        'created_at'  => task_1.created_at.as_json,
        'updated_at'  => task_1.updated_at.as_json,
        'user_id'     => task_1.user_id
      }
    ])
  end
end

describe 'POST /api/tasks' do
  include_context :doorkeeper_app_with_token
  let(:due_date) { Date.tomorrow.to_s }
  let(:request_params) {
    {
      access_token: access_token.token,
      task: {
        title: 'Title', 
        description: 'Description', 
        priority: 666,
        due_date: due_date
      }
    }
  }

  before do
    post '/api/tasks', params: request_params
  end

  it {
    task = user.tasks.last
    expect(json).to eq(
      {
        'id'           => task.id,
        'title'        => 'Title',
        'description'  => 'Description',
        'priority'     => 666,
        'due_date'     => Date.parse(due_date).strftime("%Y-%m-%d"),
        'completed'    => false,
        'created_at'   => task.created_at.as_json,
        'updated_at'   => task.updated_at.as_json,
        'user_id'      => task.user_id
      }
    )
  }
end

describe 'PATCH /api/tasks/:id' do
  include_context :doorkeeper_app_with_token
  let(:task) { create(:task, user: user) }
  let(:request_params) {
    {
      access_token: access_token.token,
      task: {
        description: 'The simple description for task', 
      }
    }
  }

  before do
    patch "/api/tasks/#{task.id}", params: request_params
    task.reload
  end

  it { expect(task.description).to eq('The simple description for task') }
end

describe 'DELETE /api/tasks/:id' do
  include_context :doorkeeper_app_with_token
  let!(:task) { create(:task, user: user) }
  let(:request_params) {
    {
      access_token: access_token.token,
    }
  }

  it {
    expect {
      delete "/api/tasks/#{task.id}", params: request_params
    }.to change{ user.tasks.count }.from(1).to(0)
  }
end
