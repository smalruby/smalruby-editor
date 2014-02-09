# encoding: utf-8
# language: ja
@javascript
機能: sensing_input_mouse_push_or_down - 「条件:マウスの[▼左ボタン]が[▼押された]」ブロック
  シナリオ: [▼押された]ブロックのみ配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "sensing_input_mouse_push_or_down", :x => "0", :y => "0"}
      %field{:name => "MOUSE_BUTTON"}<
        M_LBUTTON
      %field{:name => "POD"}<
        push
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    Input.mouse_push?(M_LBUTTON)

    """

  シナリオ: 文と[▼押された]ブロックを配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true" }
      %value{:name => "ARG"}
        %block{:type => "sensing_input_mouse_push_or_down", :x => "0", :y => "0"}
          %field{:name => "MOUSE_BUTTON"}<
            M_LBUTTON
          %field{:name => "POD"}<
            push
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    p(Input.mouse_push?(M_LBUTTON))

    """

  シナリオ: [▼押され続けている]ブロックのみ配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "sensing_input_mouse_push_or_down", :x => "0", :y => "0"}
      %field{:name => "MOUSE_BUTTON"}<
        M_LBUTTON
      %field{:name => "POD"}<
        down
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    Input.mouse_down?(M_LBUTTON)

    """

  シナリオ: 文と[▼押され続けている]ブロックを配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true" }
      %value{:name => "ARG"}
        %block{:type => "sensing_input_mouse_push_or_down", :x => "0", :y => "0"}
          %field{:name => "MOUSE_BUTTON"}<
            M_LBUTTON
          %field{:name => "POD"}<
            down
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    p(Input.mouse_down?(M_LBUTTON))

    """
