require "sqlite3"
require "csv"
require "active_record"
require "faker"
require 'open-uri'

AdminUser.delete_all
# Game.destroy_all
ContactPage.delete_all
AboutPage.delete_all
GamesGadget.delete_all


AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

# Create 100 fake games_gadgets
100.times do
  title = "#{Faker::Commerce.product_name} from #{Faker::Game.title}"
  material = Faker::Science.element
  usage = Faker::Verb.ing_form
  description = "This '#{title}' is made with #{material} and is good for #{usage}."

  games_gadget = GamesGadget.create(
    title: title,
    description: description,
    price: Faker::Commerce.price(range: 10..100)
  )

  # ADD THESE 4 LINES OF CODE:
  query = URI.encode_www_form_component(title)
  downloaded_image = URI.open("https://source.unsplash.com/600x600/?#{query}")
  games_gadget.image.attach(io: downloaded_image, filename: "m-#{title}.jpg")
  sleep(1) # <=== if youre downloading A LOT of images,
  # do yourself a favour and DONT get yourself blocked by spamming the API.
end
puts "100 games gadgets generated"




# # Specify the file path to your CSV file
# csv_file = Rails.root.join("db/games.csv")

# # Loop through the fetched data and seed it into your Rails database
# CSV.foreach(csv_file, headers: true) do |game|
#   createGames = Game.create!(
#     title:        game["title"],
#     platform:     game["platform"],
#     description:  game["description"],
#     genre:        game["genre"],
#     price:        game["price"],
#     esrb_rating:  game["esrb_rating"],
#     manufacturer: game["manufacturer"],
#     release_date: game["release_date"],
#     weight:       game["weight"],
#     stock:        game["stock"]
#   )
#   createGames.images.attach(io: File.open("public/storage/game_master_image/#{createGames.id}.jpg"), filename: "#{game["title"]}.jpg")
# sleep(1)
# end

# puts "Seed data created successfully!"

# Contact Page Info
ContactPage.create!(
  name: "Your Name",
  email: "info@jkgames.com",
  phone: "(204) 123-4567",
  address: "956 Princess St\n666 Elgin St\n431 Notre Dame St",
  message_text: "Default message text."
)
puts "Contact page data created successfully!"

AboutPage.create!(
  headline: "About JK Games",
  self_intro: "Welcome to JK Games, We're not kidding! JK Games is a locally owned and operated video game store based out of Winnipeg, Manitoba, Canada. We are an enthusiastic bunch of video game enthusiasts who just can't wait to talk to you about video games!",
  why_us: "Why shop at JK Games? We are locally owned and operated, striving for customer satisfaction. Our friendly and knowledgeable staff is here to help you find what you need.",
  stores_addresses: "956 Princess St, 666 Elgin St, 431 Notre Dame St",
  store_hours: "Monday - Friday: 1:00am - 11:00pm\nSaturday: 1:00am - 11:00pm\nSunday: 1:00am - 6:00pm"
)
puts "About page data created successfully!"

