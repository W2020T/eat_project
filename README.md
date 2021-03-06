# 作品名
eat_project
# ターゲットユーザー
食事や健康に関する情報に興味がある人を対象にしています。
# 制作背景
食事や健康についての知識を共有するコミュニティがあまりなかったため作成しました。
# 主な利用シーン
食事について気になったことや分かったことを投稿したいとき
ためになるという投稿をした人を登録したいとき
自分と価値観の合う人を探して新たな学びを得たい時
# 苦労した部分
投稿とコメントを紐付けるところです。違うコメントが削除されたり違う投稿にコメントされたりしました。
似たようなことで悩んでいる人が質問されていたのでそれを参考にしました。
# 使用技術
フロントエンド

* HTML/CSS
* JavaScript
* Bootstrap 

バックエンド

* Ruby 2.6.6
* Rails 6.1.4（遭遇するエラーをGoogle検索すれば関連する日本語のドキュメント、もしくは何かしらの日本語のサイトがヒットするので自分にとっては学びやすい言語だと判断したためこの言語を選択しました。）
* Mysql(オープンソースでありさまざまなOSに対応しているため採用しました。)

# E-R図
eat_projectのdioファイルにEーR図を記載しています。
# その他

* Rubocop(コード整形）（余計なインデントや不必要なスペースなどのミスを指摘、自動修正してくれるため。）
* Rspec（単体テストの一部)（自動テストを充実させることで書いたテストの範囲内の動作を担保させるため。）
＊ (また、FactoryBotとFakerを効率的にテストコードを書くために使用しました。)

# 機能一覧

ユーザー関連

* 新規登録機能・登録情報編集機能（画像登録可能）
* ログイン機能
* ゲストログイン機能
* フォロー・フォロワー機能
* ユーザー検索機能
* 記事検索機能

投稿関連

* 新規投稿・編集・削除
* コメント機能（コメント作成・削除）
* いいね機能
* タグ投稿・編集・検索機能
* ページネーション機能(kaminari)（今使っているユーザーがどのあたりのページを見ているかがわかるようにするため実装しました）
* Active Storageを用いた画像投稿機能（テーブルの構成を変える必要がないためActive Storageを採用しました。）
# 今後実装したい項目

* レスポンシブ化（サービスの見た目・使いやすさを改善するため。）
* テストコードの充実（自動でテストする範囲を広げるため。）
* インフラにAWSを使用する（低価格で利用でき、読み込みが比較的早いから。）
* 非同期通信（編集中の文章を一時保存するなどの機能をユーザーに意識させることなく実装することができため。パフォーマンスを向上させるため。）
* SNSログイン機能（ユーザがパスワードを覚える手間を省かせるため。）
* gemを用いたパンくず機能（ユーザがどこにいるのか視覚的にわかりやすくするため。）
