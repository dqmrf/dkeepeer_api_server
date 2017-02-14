FactoryGirl.define do
  factory :access_token, class: Doorkeeper::AccessToken do
    token { Faker::Crypto.sha256 }
  end
end
