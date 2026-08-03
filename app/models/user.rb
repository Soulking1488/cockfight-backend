# app/models/user.rb
class User < ApplicationRecord
  has_secure_password
  has_many :chickens, dependent: :destroy
  has_many :bets, dependent: :destroy

  enum :role, { owner: 0, admin: 1 }, default: :owner

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end
