class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Add the province field and validation
  validates :province, presence: true

  PROVINCES = {
    'Alberta' => 'AB', 'British Columbia' => 'BC', 'Manitoba' => 'MB', 'New Brunswick' => 'NB',
    'Newfoundland and Labrador' => 'NL', 'Nova Scotia' => 'NS', 'Ontario' => 'ON', 'Prince Edward Island' => 'PE',
    'Quebec' => 'QC', 'Saskatchewan' => 'SK'
  }.freeze

  def self.provinces_list
    PROVINCES.map { |full_name, code| [full_name, code] }
  end
end
