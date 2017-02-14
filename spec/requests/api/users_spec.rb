require "spec_helper"

describe 'GET /api/users' do
  let!(:user_1) { create(:user) }
  let!(:user_2) { create(:user) }

  before do
    get '/api/users'
  end

  it { expect(json['users']).to have(2).items }
  it { expect(json['users']).to eq([
      {
        'id'         => user_1.id,
        'email'      => user_1.email,
        'first_name' => user_1.first_name,
        'last_name'  => user_1.last_name,
        'created_at' => user_1.created_at.as_json,
        'updated_at' => user_1.updated_at.as_json
      },
      {
        'id'         => user_2.id,
        'email'      => user_2.email,
        'first_name' => user_2.first_name,
        'last_name'  => user_2.last_name,
        'created_at' => user_2.created_at.as_json,
        'updated_at' => user_2.updated_at.as_json
      }
    ])
  }
end

describe 'GET /api/users/:id' do
  context 'with valid user' do
    let(:user) { create(:user) }

    before do
      get "/api/users/#{user.id}"
    end

    it { expect(json).to eq({
        'id'         => user.id,
        'email'      => user.email,
        'first_name' => user.first_name,
        'last_name'  => user.last_name,
        'created_at' => user.created_at.as_json,
        'updated_at' => user.updated_at.as_json
      })
    }
  end

  context 'with invalid user' do
    let(:id) { 'qwerty' }

    it {
      expect {
        get "/api/users/#{id}"
      }.to raise_error ActiveRecord::RecordNotFound
    }
  end
end

describe 'POST /api/users' do
  context 'with valid params' do
    let(:email)      { Faker::Internet.email }
    let(:first_name) { Faker::Name.first_name }
    let(:last_name)  { Faker::Name.last_name }
    let(:password)   { Faker::Number.number(10) }
    let(:request_params) {
      {
        user: {
          email: email,
          first_name: first_name,
          last_name: last_name,
          password: password,
          password_confirmation: password
        }
      }
    }

    before do
      post '/api/users', params: request_params
    end

    it { expect(json['id']).to be }
    it { expect(json['email']).to eq email }
    it { expect(json['first_name']).to eq first_name }
    it { expect(json['last_name']).to eq last_name }
  end

  context 'with invalid params' do
    let(:exisging_user) { create(:user) }
    let(:request_params) {
      {
        user: {
          first_name: '',
          email: exisging_user.email
        }
      }
    }

    before do
      post '/api/users', params: request_params
    end

    it { expect(json).to eq(
      {
        'message' => 'Validation Failed',
        'errors' => [
          "Password can't be blank", 
          "First name can't be blank", 
          "Last name can't be blank"
        ]
      })
    }
  end
end

describe 'PATCH /api/users/:id' do
  let(:user) { create(:user) }

  context 'with valid params' do
    let(:request_params) {
      {
        user: {
          first_name: 'Misha',
          last_name: 'Pelykh'
        }
      }
    }

    before do
      patch "/api/users/#{user.id}", params: request_params
      user.reload
    end

    it { expect(user.first_name).to eq 'Misha' }
    it { expect(user.last_name).to eq 'Pelykh' }

    it { expect(json['id']).to be }
    it { expect(json['first_name']).to eq 'Misha' }
    it { expect(json['last_name']).to eq 'Pelykh' }
  end

  context 'with invalid params' do
    let(:request_params) {
      {
        user: {
          first_name: ''
        }
      }
    }

    before do
      patch "/api/users/#{user.id}", params: request_params
    end

    it { expect(json).to eq(
      {
        'message' => 'Updating Failed',
        'errors' => [
          "First name can't be blank"
        ]
      })
    }
  end
end

describe 'DELETE /api/users/:id' do
  let(:user) { create(:user) }

  before do
    delete "/api/users/#{user.id}"
  end

  it { expect(User.count).to eq 0 }
  it { expect(json).to eq({ 'id' => user.id }) }
end
