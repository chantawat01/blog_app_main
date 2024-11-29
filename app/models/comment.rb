class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates :body, presence: true  # เพิ่ม validation สำหรับคอมเมนต์
end
