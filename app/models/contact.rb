class Contact < ApplicationRecord
  enum :category, { family: 0, friends: 1, work: 2 }

  validates :name, presence: true
  validates :surname, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
  validates :category, presence: true

  before_save :normalize_fields

  private

  def normalize_fields
    self.name = capitalize_name(name) if name.present?
    self.surname = capitalize_name(surname) if surname.present?
    self.email = email.downcase.strip if email.present?
    self.phone = normalize_phone(phone) if phone.present?
  end

  def capitalize_name(name_string)
    name_string.strip.split(' ').map do |part|
      part.capitalize
    end.join(' ')
  end

  def normalize_phone(phone_string)
    phone_string.gsub(/[^\d+]/, '')
  end
end
