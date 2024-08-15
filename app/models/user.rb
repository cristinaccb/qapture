class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :uploads
  has_many :events, through: :uploads
  has_many :messages, dependent: :destroy
  # Add Devise for user authentication
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable


  def host?
    role == 'host'
  end

  def guest?
    role == 'guest'
  end

  
end
