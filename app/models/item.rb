class Item < ApplicationRecord
  belongs_to :box
  belongs_to :user, optional: true
  has_one_attached :picture
  validates :description, presence: true
end
