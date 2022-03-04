crumb :root do
  link 'Home', posts_path
end

crumb :users_show do
  link 'ユーザー詳細', user_path
  parent :root
end

crumb :user_edit do
  link 'ユーザー編集'
  parent :user_show
end

crumb :post_new do
  link '新しいクチコミ投稿', new_post_path
  parent :root
end

rumb :post_show do
  link '投稿詳細', post_path
  parent :root
end
crumb :user do |user|
  link user.name, user_path(user)
  parent :root
end
