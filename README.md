# Sinatraメモアプリ

## Sinatraを用いて簡易的なメモアプリを作成しました
<img width="732" alt="スクリーンショット 2021-08-05 10 58 05" src="https://user-images.githubusercontent.com/80372144/128279002-d5693df4-8531-4da7-a2ac-af9a4f46bc29.png">

## 主な使い方
1. `追加`ボタンを押すと新規メモ作成画面へ移行します
2. メモタイトル・メモ内容を書き込み後、`保存`ボタンを押すとメモが保存できます
3. トップ画面のメモ一覧より作成したメモをクリックすると`変更`or`削除`ができます
4. `変更`ボタンを押すとメモの編集画面へ移行します
5. `削除`ボタンを押すとメモが削除されます

## メモアプリのインストール法

Forkボタンを押して、自分のアカウントのリモートリポジトリにコピーをします。
作業PCの任意の作業ディレクトリにて git clone してください。
ブランチの指定をしてcloneする必要があるので-bオプションを指定します。
$ git clone -b ブランチ名 https://github.com/自分のアカウント名/sinatra-memo_app.git
clone後、次のコマンドでSinatraを立ち上げてください。
$ bundle exec ruby main.rb 
