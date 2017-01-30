FactoryGirl.define do

  sequence :appN do |n|
    "App#{n}"
  end

  factory :app do
    name { generate(:appN) }
  end

end
