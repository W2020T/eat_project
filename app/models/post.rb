# frozen_string_literal: true

class Post < ApplicationRecord
  validates :content, { presence: true, length: { maximum: 100 } }
  validates :user_id, { presence: true }
  belongs_to :user
  has_many :comments, dependent: :destroy
  def user
    User.find_by(id: user_id)
  end

  def self.search(search)
    if search
      Post.where(['content LIKE ?', "%#{search}%"])
    else
      Post.all
    end
  end
end
