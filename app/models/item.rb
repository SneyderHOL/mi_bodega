class Item < ApplicationRecord
  belongs_to :box
  belongs_to :user, optional: true
  has_one_attached :picture
  validates :description, presence: true
  validates :picture, presence: { message: "needs to be attached" }
  validate :image_type_validation

  def available_boxes
    boxes = []
    account = self.box.account
    account.boxes.each do |box|
      if box.id != self.box.id
        boxes.push([box.name.capitalize, box.id])
      end
    end
    boxes
  end

  private

  def image_type_validation
    valid_types = ["image/png", "image/jpeg"]
    if picture.attached? && !picture.content_type.in?(valid_types)
      errors.add(:picture, "must be a JPEG or PNG file.")
    end
  end

  
end
