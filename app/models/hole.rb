class Hole < ApplicationRecord
  has_many :strategy_infos
  belongs_to :golfclub
  belongs_to :course

  has_one_attached :map_r
  has_one_attached :map_b
  has_one_attached :map_l

  validates :hole_number, presence: true, length: { maximum: 2 }
  validates :number_of_pars, presence: true, length: { maximum: 2 }
  validates :map_r, content_type: { in: [:png, :jpg, :ipeg], message: 'のファイル形式が違います' },
                    size: { less_than_or_equal_to: 10.megabytes, message: 'の容量は10MB以内にしてください' }
  validates :map_b, content_type: { in: [:png, :jpg, :ipeg], message: 'のファイル形式が違います' },
                    size: { less_than_or_equal_to: 10.megabytes, message: 'の容量は10MB以内にしてください' }
  validates :map_l, content_type: { in: [:png, :jpg, :ipeg], message: 'のファイル形式が違います' },
                    size: { less_than_or_equal_to: 10.megabytes, message: 'の容量は10MB以内にしてください' }
end
