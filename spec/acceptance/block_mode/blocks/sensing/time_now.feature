# encoding: utf-8
# language: ja
@javascript
機能: sensing_time_now - 「変数:現在の[▼時]」ブロック
  シナリオ: ブロックのみ配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "sensing_time_now", :x => "0", :y => "0"}
      %field{:name => "METHOD"}<
        hour
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    Time.now.hour

    """

  シナリオ: 文とブロックを配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true" }
      %value{:name => "ARG"}
        %block{:type => "sensing_time_now", :x => "0", :y => "0"}
          %field{:name => "METHOD"}<
            hour
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    p(Time.now.hour)

    """
