# encoding: utf-8
# language: ja
@javascript
機能: Motion - 動きジャンル
  シナリオ: 「(　)歩動かす」ブロックを配置する
    前提 "ブロック" タブを表示する

    もし "motion_move" ブロックを配置する
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    move(0)

    """
