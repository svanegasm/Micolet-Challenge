FactoryBot.define do
    factory :participant do
        email { "MyString" }
        women_fashion_preference { true }
        men_fashion_preference { true }
        children_fashion_preference { true }
    end
end