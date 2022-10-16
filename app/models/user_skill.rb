class UserSkill < ApplicationRecord
  validates :rating, presence: true
  belongs_to :user
  belongs_to :skill
end
