# アプリケーションの概要
Solidusを用いたECサイト。

# 実装内容
・商品詳細ページ（例：https://ec-potepan-kk.herokuapp.com/potepan/products/3）  
・カテゴリー別アーカイブページ（例：https://ec-potepan-kk.herokuapp.com/potepan/categories/7）  
・トップページ（https://ec-potepan-kk.herokuapp.com/potepan）

# 技術的ポイント
・**Docker**を用いたRails開発環境構築  
・Rails製OSSの**Solidus**のキャッチアップ  
・**AWS S3**への画像保存  
・**RSpec**でテスト記述  
・**Ajax**を用いた非同期処理（セレクトボックスの項目に応じた画像の切り替え）  
・**Fat Controllerを避ける**ため、一部ロジックをモデルで定義  
・大量のデータにも対応できるよう、Rubyでのデータ処理を減らし**極力SQL側で処理**  
・**Bootstrap**によるレスポンシブ対応  
・**Rubocop**を使用したコード規約に沿った開発  
・提出したプルリクエストに**現役Webエンジニア3人以上からレビュー**を受けて修正し、  
　マージ承認をもらってからマージするという流れで開発  

# アプリケーションの機能
## 商品詳細ページ
・商品詳細の表示  
・関連商品出力  

## カテゴリー別アーカイブページ
・カテゴリーごとの商品一覧表示  
・商品カテゴリーツリーの動的表示

# 環境
■フレームワーク  
　Ruby on Rails  
■インフラ  
　heroku, Docker  
■データベース  
　MySQL
