class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :uploads
  has_many :events, through: :uploads
  # Add Devise for user authentication
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
end
