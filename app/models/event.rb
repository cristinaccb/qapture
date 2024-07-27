class Event < ApplicationRecord
  has_many :uploads
  has_many :users, through: :uploads
  has_one :qr_code

    validates :name, presence: true
    validates :date, presence: true
    validates :location, presence: true
  end
