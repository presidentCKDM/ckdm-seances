FactoryGirl.define do
  factory :user do
    sequence(:name)  		    {|i| "user ##{i}"}
    sequence(:email)        {|i| "user-#{i}@gmail.com"}
    sequence(:token)        {|i| "token ##{i}"}

    factory :admin_user do
      is_admin              true
    end
  end

  factory :group do
  	sequence(:name)  		    {|i| "group ##{i}"}
  end

  factory :location do
  	sequence(:name)  		    {|i| "location ##{i}"}
  end

  factory :training_session do
    association             :location
    sequence(:description)  {|i| "training_session ##{i}"}
    started_at              Date.today
  end

  factory :allowance do
    association             :group
    association             :training_session
  end

  factory :invitation do
    association             :user
    association             :training_session
  end

  factory :membership do
    association             :group
    association             :user
  end
end