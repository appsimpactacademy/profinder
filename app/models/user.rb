class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_skills, dependent: :destroy
  has_many :skills, through: :user_skills

  validates :name, :city, :country, presence: true
  validates :email, :contact_number, presence: true, uniqueness: true 

  before_save :check_state_present
  before_save :set_full_country_name
  validate :validate_country

  def set_full_country_name
    self.full_country_name = country_name
  end

  def country_name
    country = ISO3166::Country[self.country]
    country.translations[I18n.locale.to_s] || country.common_name || country.iso_short_name
  end

  def check_state_present
    self.state = self.country if state.nil?
  end

  def validate_country
    return if country.nil?

    unless User.country_code_list.include?(country)
      errors.add(:country, 'is not valid')
    end 
  end

  def self.country_code_list
    ISO3166::Country.all.map { |country| country.alpha2 }
  end

  def self.country_name_list
    ISO3166::Country.all.map { |country| country.name }
  end

end
