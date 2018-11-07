# ポテパンキャンプECサイトリポジトリ

## 開発環境のセットアップ
ポテパンキャンプで開発を行っていくため、一般的なMacでのRails開発環境のセットアップをおこないます。

### homebrew のインストール
ruby のインストールや、その他のパッケージのインストールのため、[homebrew](https://brew.sh/index_ja.html)をインストールします。

ターミナルを開き、下記コマンドを入力します。

```bash
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### Docker のインストール
```bash
brew update
brew install caskroom/cask/brew-cask
brew cask install docker
```

### Docker の起動
```bash
open /Applications/Docker.app
```

### プロジェクトのフォーク

[potapanec](https://bitbucket.org/potepancamp/potepanec)へ移動し、左のプラスボタンをクリックします。

![](docs/images/installation/fork1.png)

** Fork ** this repository のリンクをクリックします。

![](docs/images/installation/fork2.png)

所有者が自分になっていることを確認して、リポジトリをフォークします。

![](docs/images/installation/fork3.png)


### プロジェクトの clone

上記でフォークしたリポジトリを自分のPCにクローンします

例：

```
git clone https://[your_account_name]@bitbucket.org/[your_account_name]/potepanec.git
```

### docker-compose up
上記でクローンしたディレクトリに移動し、ターミナルで下記コマンドを実行します

```bash
docker-compose up --build
```

### データベースの作成と最新状態へ移行

ターミナルで下記コマンドを実行します

```bash
docker-compose exec potepanec bundle exec rails g spree:install
docker-compose exec potepanec bundle exec rails g solidus:auth:install
```

### 動作確認

以下のURLを開き、例のような画面が表示されれば正常に動作しています。

http://localhost:3000/potepan/index.html

![](docs/images/installation/first_view.png)

### Dockerを利用しない開発環境の構築
スペック不足など、何らかの理由でDockerでの開発が困難な場合は[こちら](./WITHOUTDOCKER.md)を参考に開発環境をセットアップしてください。
