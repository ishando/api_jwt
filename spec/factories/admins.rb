FactoryGirl.define do

  sequence :adminN do |n|
    "Admin#{n}"
  end
  sequence :passN do |n|
    "pass#{n}#{n+1}#{n+2}#{n+3}"
  end

  factory :admin do
    username { generate(:adminN) }
    password { generate(:passN) }
    password_confirmation { password }
  end
end
