require "sqlite3"
require "csv"
require "active_record"

AdminUser.delete_all
# Game.destroy_all


AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

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

