class Card < ApplicationRecord
  belongs_to :user, optional: true
  validates :customer_token, presence: true
end
