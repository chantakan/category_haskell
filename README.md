# 初期設定
git cloneでダウンロードするなりする

カレントディレクトリをcategory_haskell/にする

# category_haskell

DockerでHaskellの環境構築を行う

## 0. Dockerの導入
### 0.1. [Dockerインストール](https://and-engineer.com/articles/Yb2imhEAACMAhjUx#heading3-18)

### 0.2. (linux向け)sudo無しでdockerコマンド実行
[こちら](https://qiita.com/katoyu_try1/items/1bdaaad9f64af86bbfb7)を参考にしてほしい

## 1.すぐに始める人向け
### 1.1. コンテナイメージを作成する

```
docker build -t haskell-excercise:latest .
```
"haskell-excercise:latest"は任意のイメージ名で良い

### 1.2. 作成したコンテナイメージからコンテナを作成する

```
docker run -it --name haskell-excercise-sshd haskell-excercise:latest 
```
"haskell-excercise-sshd"を任意のコンテナ名に変える
通常はこれでは入れる. コンテナへは入れない場合は次

### 1.3. 作成後コンテナへ入る方法

```
docker exec -u USN -it haskell-excercise-sshd /bin/bash
```


## 2.コンテナへssh接続して使いたい人向け

### 2.1. ユーザー登録
ssh接続先のユーザーへ入るためのユーザー名を設定できる(デフォルトはユーザー名:パスワード=USN:PWADだがこのままで良いなら2.2.へ)
```
./create.sh
```
を実行してユーザー名・パスワードを作成する
記入後に間違えた場合は
```
./reset.sh
```
を実行

### 2.2. コンテナイメージを作成する

```
docker build -t haskell-excercise:latest .
```
"haskell-excercise:latest"は任意のイメージ名で良い

### 2.3.  作成したコンテナイメージからコンテナを作成する

```
docker run -d -p 2121:22 --name haskell-excercise-sshd haskell-excercise:latest 
 
```
"haskell-excercise-sshd"を任意のコンテナ名に変える.
2121は任意のポート番号でOK


### 2.4. ssh設定
~/.ssh/config にて

```
Host haskell-exercise
	HostName localhost
	User USN
	Port 2121
```
と設定する.
haskell-exerciseは任意の名前で良い
USNは自分で決めたユーザー名

### 2.5. ssh接続
設定ができたら

```
ssh haskell-exercise
```
で接続
