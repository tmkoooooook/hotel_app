class Room < ApplicationRecord
    belongs_to :user
    has_many :reservations, dependent: :destroy
    mount_uploader :room_image, ImageUploader
    validates :room_name, presence: true
    validates :room_introduction, presence: true
    validates :room_money, presence: true
    validates :room_address, presence: true
end
