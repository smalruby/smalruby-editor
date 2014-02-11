# encoding: utf-8
# language: ja
@javascript
@standalone
機能: Run - プログラムの実行(standaloneモード)
  シナリオ: 実行前にプログラムのシンタックスエラーをチェックできる
    前提 "Ruby" タブを表示する
    かつ プログラムの名前に "01.rb" を指定する
    かつ テキストエディタに "puts Hello, World!'" を入力済みである

    もし "実行ボタン" をクリックする
    かつ JavaScriptによるリクエストが終わるまで待つ

    ならば "メッセージ" に "エラー" を含むこと
    かつ "メッセージ" に "プログラムを実行できませんでした" を含むこと
    かつ "メッセージ" に "1行、19文字: syntax error, unexpected tSTRING_BEG, expecting keyword_do or '{' or '('" を含むこと
    かつ "メッセージ" に "1行: unterminated string meets end of file" を含むこと
