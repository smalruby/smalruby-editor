# encoding: utf-8
# language: ja
@javascript
@standalone
機能: Run - プログラムの実行(standaloneモード)
  背景:
    前提 "Ruby" タブを表示する

  シナリオ: プログラム実行時に、実行したプログラムによって発生したエラーメッセージを表示できる
    前提 プログラムの名前に "01.rb" を指定する

    もし テキストエディタに "raise '不具合'" を入力済みである
    かつ "実行ボタン" をクリックする
    かつ JavaScriptによるリクエストが終わるまで待つ

    ならば "メッセージ" に "エラー" を含むこと
    かつ "メッセージ" に "プログラムを実行できませんでした" を含むこと
    かつ "メッセージ" に "1行: in `<main>': 不具合 (RuntimeError)" を含むこと

  シナリオ: ログインIDにスペースを含む場合でもプログラム実行時に、実行したプログラムによって発生したエラーメッセージを表示できる
    前提 プログラムの名前に "01.rb" を指定する
    かつ テキストエディタに "raise '不具合'" を入力済みである

    もし "ログインボタン" をクリックする
    かつ JavaScriptによるアニメーションが終わるまで待つ
    かつ "ログインダイアログの名前" に "1102 name" を指定する
    かつ "ログインダイアログのログインボタン" をクリックする
    かつ JavaScriptによるアニメーションが終わるまで待つ
    かつ "実行ボタン" をクリックする
    かつ JavaScriptによるリクエストが終わるまで待つ

    ならば "メッセージ" に "エラー" を含むこと
    かつ "メッセージ" に "プログラムを実行できませんでした" を含むこと
    かつ "メッセージ" に "1行: in `<main>': 不具合 (RuntimeError)" を含むこと

  シナリオ: プログラム名にシェルのコマンドが埋め込まれていてもファイル名として扱い、実行したプログラムによって発生したエラーメッセージを表示できる
    前提 テキストエディタに "raise '不具合'" を入力済みである

    もし プログラムの名前に "x; echo 'foo' 1>&2" を指定する
    かつ "実行ボタン" をクリックする
    かつ JavaScriptによるリクエストが終わるまで待つ

    ならば "メッセージ" に "エラー" を含むこと
    かつ "メッセージ" に "プログラムを実行できませんでした" を含むこと
    かつ "メッセージ" に "1行: in `<main>': 不具合 (RuntimeError)" を含むこと

#  シナリオ: 実行前にプログラムのシンタックスエラーをチェックできる
#    前提 プログラムの名前に "01.rb" を指定する
#    かつ テキストエディタに "puts Hello, World!'" を入力済みである
#
#    もし "実行ボタン" をクリックする
#    かつ JavaScriptによるリクエストが終わるまで待つ
#
#    ならば "メッセージ" に "エラー" を含むこと
#    かつ "メッセージ" に "プログラムを実行できませんでした" を含むこと
#    かつ "メッセージ" に "1行、19文字: syntax error, unexpected tSTRING_BEG, expecting keyword_do or '{' or '('" を含むこと
#    かつ "メッセージ" に "1行: unterminated string meets end of file" を含むこと

#  シナリオ: 既存のファイルがある状態でプログラムを実行し、上書き保存をキャンセルする
#    前提 プログラムの名前に "01.rb" を指定する
#    かつ テキストエディタに "puts Hello, World!'" を入力済みである
#    かつ ホームディレクトリに "n = 0" という内容の "01.rb" が存在する
#    かつ 確認ダイアログをキャンセルするようにしておく
#
#    もし "実行ボタン" をクリックする
#    かつ JavaScriptによるリクエストが終わるまで待つ
#    かつ JavaScriptによるリクエストが終わるまで待つ
#
#    ならば 確認メッセージ "前に01.rbという名前でセーブしているけど本当にセーブしますか？\nセーブすると前に作成したプログラムは消えてしまうよ！" を表示すること
#    かつ "メッセージ" に "プログラムの実行をキャンセルしました" を含むこと
#    かつ ホームディレクトリの "01.rb" の内容が "n = 0" であること

