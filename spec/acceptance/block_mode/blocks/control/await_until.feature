# encoding: utf-8
# language: ja
@javascript
機能: control_await_until - 「<　>まで待つ」ブロック
  シナリオ: ブロックのみ配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "control_await_until", :x => "0", :y => "0"}
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    await until true

    """

  シナリオ: 値を設定したブロックを配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "control_await_until", :x => "0", :y => "0"}
      %value{:name => "COND"}
        %block{:type => "operators_false"}
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    await until false

    """
