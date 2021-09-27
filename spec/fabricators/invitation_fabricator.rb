Fabricator(:invitation) do
  name { Faker::Name.name }
  email { Faker::Internet.email }
  message { Faker::Lorem.paragraphs(2) }
  inviter { Fabricate(:user)}
end