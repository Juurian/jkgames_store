# app/models/contact_page.rb
class ContactPage < ApplicationRecord
  validates :name, :email, :phone, :address, :message_text, presence: true
end
