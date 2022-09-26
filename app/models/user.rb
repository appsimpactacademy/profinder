class User < ApplicationRecord
  validates :name, :city, :state, :country, :contact_number, presence: true
  validates :email, presence: true, uniqueness: true
end
