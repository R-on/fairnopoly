require 'faker'

FactoryGirl.define do
  factory :auction, aliases: [:appended_object] do
    seller
    categories_and_ancestors {|c| [c.association(:category)] }
    title     { Faker::Lorem.sentence(rand(3)+1).chomp '.' }
    content   { Faker::Lorem.paragraph(rand(7)+1) }
    expire    { (rand(10) + 2).hours.from_now }
    condition { ["new", "old"].sample }
    price_cents { Random.new.rand(500000)+1 }
    quantity  { (rand(10) + 1) }
    
    transport { Auction.transport.values.sample(rand(3)+1) }
    transport_details "transport_details"    
    payment   { Auction.payment.values.sample(rand(5)+1) }
    payment_details "payment_details"
    after(:build) do |auction|
      auction.images << FactoryGirl.build(:image,:auction => auction)
      auction.transaction ||= FactoryGirl.build(:preview_transaction,:auction => auction)
    end
    factory :second_hand_auction do
      condition "old"
    end
    
    factory :no_second_hand_auction do
      condition "new"
    end
    
  end
end