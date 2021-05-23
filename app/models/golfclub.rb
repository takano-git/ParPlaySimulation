class Golfclub < ApplicationRecord
  has_many :courses, dependent: :destroy
  has_many :holes, through: :courses, dependent: :destroy

  accepts_nested_attributes_for :courses, allow_destroy: true
  
  VALID_URL_REGEX = /https?:\/\/[\w\/:%#\$&\?\(\)~\.=\+\-]+|\A\z/
  VALID_VIDEO_REGEX = /\A(https\:\/\/)?(www\.)?(youtube\.com\/watch\?v=|youtu\.be\/)+[\S]{11}\z/

  validates :name, presence: true, length: { maximum: 50 }
  validates :home_page_url, format: { with: VALID_URL_REGEX }
  validates :strategy_video, format: { with: VALID_VIDEO_REGEX }, allow_blank: true
end
