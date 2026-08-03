# app/models/chicken.rb
class Chicken < ApplicationRecord
  belongs_to :user

  # Weight classes for roosters
  WEIGHT_CLASSES = ["Bantamweight", "Featherweight", "Lightweight", "Heavyweight", "Absolute Chonk"].freeze

  validates :name, presence: true
  validates :weight, presence: true, numericality: { greater_than: 0 }
  validates :weight_class, presence: true, inclusion: { in: WEIGHT_CLASSES }

  # Default initial values
  before_validation :set_defaults, on: :create

  private

  def set_defaults
    self.record_wins ||= 0
    self.record_losses ||= 0
    self.status ||= "Healthy"
  end
end
