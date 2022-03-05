crumb :posts do
  link '投稿一覧', 'posts/index'
end
crumb :users do
  link 'ユーザ一覧', users_path
end
crumb :users_show do
  link 'ユーザー詳細', users_path
  parent :users
end

crumb :user_edit do
  link 'ユーザー編集'
  parent :users_show
end

crumb :posts_new do
  link '新しい投稿', new_post_path
  parent :posts
end

rumb :posts_show do
  link '投稿詳細', posts_path
  parent :posts
end
crumb :post_edit do
  link '投稿編集'
  parent :post_show
end
crumb :user do |user|
  link "#{user.name}さんの詳細", user_path(user)
  parent :root
end
crumb :user do |user|
  link "#{user.name}さんのフォロワー", user_path(user)
  parent :users_show
end
crumb :user do |user|
  link "#{user.name}さんの詳細", user_path(user)
  parent :users_show
end
crumb :content_search do |search|
  if search == ''
    link '検索結果', posts_search_path
  else
    link "「#{search}」の検索結果", posts_search_path
  end
  parent :posts
end
crumb :users_search do |search|
  if search == ''
    link '検索結果', posts_search_path
  else
    link "「#{search}」の検索結果", posts_search_path
  end
  parent :posts
end
crumb :post do |post|
  link post.content, post
  parent :posts
end
