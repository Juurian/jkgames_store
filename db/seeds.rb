require "sqlite3"
require "csv"
require "active_record"

Game.destroy_all

# AdminUser.delete_all

# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

# Specify the file path to your CSV file
csv_file = Rails.root.join("db/games.csv")

# Loop through the fetched data and seed it into your Rails database
CSV.foreach(csv_file, headers: true) do |game|
  Game.create!(
    title:        game["title"],
    platform:     game["platform"],
    description:  game["description"],
    genre:        game["genre"],
    price:        game["price"],
    esrb_rating:  game["esrb_rating"],
    manufacturer: game["manufacturer"],
    release_date: game["release_date"],
    weight:       game["weight"],
    stock:        game["stock"]
  )
end

puts "Seed data created successfully!"
