FactoryGirl.define do

  sequence :clientN do |n|
    "Client%03d" % n
  end

  factory :client do
    name { generate(:clientN) }
  end

end
