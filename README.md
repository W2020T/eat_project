# 作品名
eat_project
# ターゲットユーザー
食事や健康に関する情報に興味がある人を対象にしています。
# 制作背景
食事や健康についての知識を共有するコミュニティがあまりなかったため作成しました。
# 主な利用シーン
食事について気になったことや分かったことを投稿したいとき
ためになるという投稿をした人を登録したいとき
# 使用技術
フロントエンド

* HTML/CSS
* JavaScript
* Bootstrap 

バックエンド

* Ruby 2.6.6
* Rails 6.1.4（遭遇するエラーをGoogle検索すれば関連する日本語のドキュメント、もしくは何かしらの日本語のサイトがヒットするので自分にとっては学びやすい言語だと判断したためこの言語を選択しました。）
* Mysql 



# その他

* Rubocop(コード整形）（余計なインデントや不必要なスペースなどのミスを指摘、自動修正してくれるため。）
* Rspec（単体テストの一部)（自動テストを充実させることで書いたテストの範囲内の動作を担保させるため。）


# 機能一覧

ユーザー関連

* 新規登録機能・登録情報編集機能（画像登録可能）
* ログイン機能
* ゲストログイン機能
* フォロー・フォロワー機能
* ユーザー検索機能

投稿関連
* 新規投稿・編集・削除
* いいね機能
* ページネーション機能(kaminari)

# 今後実装したい項目
* コメント機能
* レスポンシブ化（サービスの見た目・使いやすさを改善するため。）
* テストコードの充実（自動でテストする範囲を広げるため。）
* インフラにAWSを使用する（低価格で利用できるから。）
* 非同期通信（編集中の文章を一時保存するなどの機能をユーザーに意識させることなく実装することができため。パフォーマンスを向上させるため。）
