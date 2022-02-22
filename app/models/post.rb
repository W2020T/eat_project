# frozen_string_literal: true

class Post < ApplicationRecord
  validates :content, { presence: true, length: { maximum: 100 } }
  validates :user_id, { presence: true }
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image
  def user
    User.find_by(id: user_id)
  end
end
