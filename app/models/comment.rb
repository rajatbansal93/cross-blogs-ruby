# Comment
class Comment < ApplicationRecord
  belongs_to :article

  validates :article, presence: true
  validates :title, presence: true, length: { maximum: 120 }
  validates :content, presence: true, length: { maximum: 32000 }
  validates :email, presence: true, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/
end
