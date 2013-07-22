FactoryGirl.define do
  factory :user do
    name { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password 'password'
  end

  factory :topic do
    title {Faker::Lorem.words.join(' ')}
    content {Faker::Lorem.paragraph(5)}
    user
  end

  factory :user_with_topics, :parent => :user do
    after(:create) do |u|
      3.times {
        create(:topic, :user => u)
      }
    end
  end

end
