class Message < ApplicationRecord
  default_scope -> { order(created_at: :asc) }
  validates :from_id, presence: true
  validates :to_id, presence: true
  validates :content, presence: true, length: { maximum: 300 }
end
