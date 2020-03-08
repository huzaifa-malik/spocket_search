countries = []
100.times do
  countries << {name: Faker::Address.country, created_at: Time.current, updated_at: Time.current}
end
countries.uniq! { |country| country[:name]}
country_ids = Country.insert_all(countries)

products = []
100.times do
  offset = rand(countries.length)
  rand_country = country_ids.rows.flatten.first(offset).last

  tags = 3.times.map {Faker::Game.genre.downcase}
  products << {
    title: Faker::Game.title,
    description: Faker::Lorem.characters,
    country_id: rand_country,
    tags: tags,
    price: rand(11.2...76.9).round(2).to_s,
    created_at: Time.current,
    updated_at: Time.current,
  }
end

Product.insert_all(products)
