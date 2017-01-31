FactoryGirl.define do

  sequence :clientN do |n|
    "Client#{n}"
  end

  factory :client do
    name { generate(:clientN) }
  end

end
