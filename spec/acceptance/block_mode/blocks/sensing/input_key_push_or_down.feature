# encoding: utf-8
# language: ja
@javascript
機能: sensing_input_key_push_or_down - 「条件:キーボードの[▼キー]が[▼押された]」ブロック
  シナリオ: [▼押された]ブロックのみ配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "sensing_input_key_push_or_down", :x => "0", :y => "0"}
      %field{:name => "KEY"}<
        K_SPACE
      %field{:name => "POD"}<
        push
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    Input.key_push?(K_SPACE)

    """

  シナリオ: 文と[▼押された]ブロックを配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true" }
      %value{:name => "ARG"}
        %block{:type => "sensing_input_key_push_or_down", :x => "0", :y => "0"}
          %field{:name => "KEY"}<
            K_SPACE
          %field{:name => "POD"}<
            push
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    p(Input.key_push?(K_SPACE))

    """

  シナリオ: [▼押され続けている]ブロックのみ配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "sensing_input_key_push_or_down", :x => "0", :y => "0"}
      %field{:name => "KEY"}<
        K_SPACE
      %field{:name => "POD"}<
        down
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    Input.key_down?(K_SPACE)

    """

  シナリオ: 文と[▼押され続けている]ブロックを配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true" }
      %value{:name => "ARG"}
        %block{:type => "sensing_input_key_push_or_down", :x => "0", :y => "0"}
          %field{:name => "KEY"}<
            K_SPACE
          %field{:name => "POD"}<
            down
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    p(Input.key_down?(K_SPACE))

    """
