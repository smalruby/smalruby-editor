# encoding: utf-8
# language: ja
@javascript
機能: sensing_input_mouse_pos_y - 「変数:マウスのy座標」ブロック
  シナリオ: ブロックのみ配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "sensing_input_mouse_pos_y", :x => "0", :y => "0"}
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    Input.mouse_pos_y

    """

  シナリオ: 文とブロックを配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true" }
      %value{:name => "ARG"}
        %block{:type => "sensing_input_mouse_pos_y"}
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    p(Input.mouse_pos_y)

    """
