# Sinatraメモアプリ(DB利用)

## はじめに
### Sinatraを用いて簡易的なメモアプリを作成しました
<img width="732" alt="スクリーンショット 2021-08-05 10 58 05" src="https://user-images.githubusercontent.com/80372144/128279002-d5693df4-8531-4da7-a2ac-af9a4f46bc29.png">


## 主な使い方
1. `追加`ボタンを押すと新規メモ作成画面へ移行します
2. メモタイトル・メモ内容を書き込み後、`保存`ボタンを押すとメモが保存できます
3. トップ画面のメモ一覧より作成したメモをクリックすると`変更`or`削除`ができます
4. `変更`ボタンを押すとメモの編集画面へ移行します
5. `削除`ボタンを押すとメモが削除されます

## PostgreSQLの導入
メモデーターの保存先はPostgreSQLになります。メモアプリインストール前にPostgreSQLの設定を行ってください。
1. `sinatra_app`のデータベースを以下のコマンドで作成します。
```
create database sinatra_app;
```
2. `memos`のテーブルを以下のコマンドで作成します。
```
# CREATE TABLE memos
# (id char(36) not null,
# title text not null,
# message text not null,
# PRIMARY KEY(id));
```
PostgreSQLの設定は以上となります。

## メモアプリのインストール法

1. `Fork`ボタンを押すとリポジトリのフォークが開始されます。
2. 次にフォークしたリポジトリをローカル環境にクローンします。ターミナルから`git clone`を実行するために以下のコマンドを入力してください。
 
 ```
  $ git clone https://github.com/[Githubのユーザー名]/Sinatra-memo-app.git
  ```
 3. フォークしたリポジトリがクローンできたら、以下のコマンドでSinatraを立ち上げてください。

```
$ bundle exec ruby memo_app.rb 
```
4. 実行すると、ターミナルで以下のような画面が立ち上がります。
<img width="560" alt="スクリーンショット 2021-08-05 13 50 31" src="https://user-images.githubusercontent.com/80372144/128292878-e04a9b0c-f90c-486a-9df8-2e8a5eae3aac.png">

5. ターミナルを起動したまま`http://localhost:4567/memos`をブラウザに入力してください。

 下記の画面が表示されましたらメモアプリ導入完了となります。

<img width="248" alt="スクリーンショット 2021-08-05 13 45 56" src="https://user-images.githubusercontent.com/80372144/128293131-182cfe35-e657-4813-98b6-c145ef804a81.png">

