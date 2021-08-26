FactoryBot.define do
  factory :customer do
    import

    first_name { 'Jack' }
    last_name { 'Devis' }
    email { 'jackdevis@gmail.com' }
    date_of_birth { Date.today - 20.years }
  end
end
