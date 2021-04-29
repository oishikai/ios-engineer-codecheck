# 株式会社ゆめみ iOS エンジニアコードチェック課題

## 概要

本リポジトリは株式会社ゆめみのiOS エンジニアコードチェック課題です。

### 環境

- IDE：Xcode 12.4
- Swift：Swift 5.3.2
- 開発ターゲット：iOS 13.4
- サードパーティーライブラリー： SwiftPMを使って以下を導入
  - Nuke https://github.com/kean/Nuke
  - Reachability https://github.com/ashleymills/Reachability.swift
  - JGProgressHUD https://github.com/JonasGessner/JGProgressHUD

## 課題の取り組み
### ソースコードの可読性の向上
- 各変数の命名、空白やインデントを修正した
- スペース、改行も修正
- プロジェクトのフォルダ構成を整理
### ソースコードの安全性の向上
- アンラップされている箇所に if let　や guard let で対応した
- 不要なIUOを削除
- 想定外のnilの握り潰しはエラーハンドリングで対応
### バグを修正
- レイアウトとパースのエラーは修正した
- Instrumentsを使ってメモリリークの調査をしたが解決には至らなかった
### Fat VC の回避
- 通信する部分をViewControllerから切り外し、通信部分の処理を行うクラスを追加した
- カスタムセルのプロパティにセットするロジックをセル側に移動
### プログラム構造をリファクタリング
- アクセス制限を追加
- APIレスポンスのパースにDecodableを導入、エンティティを構造体で定義
- Storyboardの分割
- 画面遷移時のUIViewControllerのインスタンス時のDIを追加
### アーキテクチャを適用
- MVCを採用
### UI をブラッシュアップ
- カスタムセル追加
- 通信中のインジケーターを追加
- エラー時のアラートダイアログを追加
### 新機能を追加
- 未着手
### テストを追加
- 未着手
