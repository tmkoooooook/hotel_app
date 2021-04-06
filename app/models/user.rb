class User < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :rooms,through: :reservations, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :image_icon, ImageUploader
  validates :name, presence: true
  validates :introduction, presence: true
  validates :image_icon, presence: true
end
