class Comment < ApplicationRecord
  validates :content, { presence: true, length: { maximum: 100 } }
  validates :user_id, { presence: true }
  belongs_to :user
  validates :post_id, { presence: true }
end
