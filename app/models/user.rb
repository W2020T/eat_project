# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, { presence: true }
  validates :email, { presence: true, uniqueness: true }

  has_secure_password
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  def posts
    Post.where(user_id: id)
  end

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
  class << self
    def find_or_create_from_auth_hash(auth_hash)
      user_params = user_params_from_auth_hash(auth_hash)
      find_or_create_by(email: user_params[:email]) do |user|
        user.update(user_params)
      end
    end

    private

    def user_params_from_auth_hash(_auth_hash)
      @user.name = auth.info.name
      @user.email = auth.info.email
      @user.image = auth.info.image
    end
  end
end
