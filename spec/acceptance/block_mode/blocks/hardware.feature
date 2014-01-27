# encoding: utf-8
# language: ja
@javascript
機能: Hardware - ハードウェアジャンル
  シナリオ: 「ハードウェアを準備する」ブロックを配置する
    前提 "ブロック" タブを表示する

    もし "hardware_init_hardware" ブロックを配置する
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    init_hardware

    """
