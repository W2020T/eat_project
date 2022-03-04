crumb :root do
  link 'Home', posts_path
end

crumb :users_show do
  link 'ユーザー詳細', users_path
  parent :root
end

crumb :user_edit do
  link 'ユーザー編集'
  parent :user_show
end

crumb :posts_new do
  link '新しいクチコミ投稿', new_post_path
  parent :root
end

rumb :posts_show do
  link '投稿詳細', posts_path
  parent :root
end
crumb :post_edit do
  link '投稿編集'
  parent :post_show
end
crumb :user do |user|
  link user.name, user_path(user)
  parent :root
end
crumb :name_search do |search|
  if search == ''
    link 'クチコミ検索結果', posts_search_path
  else
    link "「#{search}」のクチコミ検索結果", posts_search_path
  end
  parent :posts
end
