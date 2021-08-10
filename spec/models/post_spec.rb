# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '#create' do
    before do
      @post = FactoryBot.build(:post)
    end

    context '空白のバリデーションチェック' do
      it 'contentが空白の場合にエラーメッセージが返ってくるか' do
        @post.content = nil
        @post.valid?
        expect(@post.errors.full_messages).to include('投稿を入力してください')
      end

      it 'contentの文字数が101文字以上の場合エラーメッセージが返ってくるか' do
        FactoryBot.build(:post, content: @post.content)
        @post.content = Faker::Lorem.characters(number: 101)
        @post.valid?
        expect(@post.errors.full_messages).to include('投稿は100文字以内で入力してください')
      end
    end
  end
end
