# encoding: utf-8
# language: ja
@javascript
機能: control_loop - 「ずっと」ブロック
  シナリオ: ブロックのみ配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "control_loop", :x => "0", :y => "0"}
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    loop do

    end

    """

  シナリオ: ブロックとその内側に文を配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "control_loop", :x => "0", :y => "0"}
      %statement{:name => "DO"}
        %block{:type => "ruby_statement", :x => "0", :y => "0"}
          %field{:name => "STATEMENT"}<
            p self
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    loop do
      p self
    end

    """
