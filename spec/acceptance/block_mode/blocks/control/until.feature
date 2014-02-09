# encoding: utf-8
# language: ja
@javascript
機能: control_until - 「<　>まで繰り返す」ブロック
  シナリオ: ブロックのみ配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "control_until", :x => "0", :y => "0"}
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    until true

    end

    """

  シナリオ: 値を設定したブロックを配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "control_until", :x => "0", :y => "0"}
      %value{:name => "COND"}
        %block{:type => "operators_false"}
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    until false

    end

    """

  シナリオ: ブロックとその内部に文を配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "control_until", :x => "0", :y => "0"}
      %value{:name => "COND"}
        %block{:type => "operators_false"}
      %statement{:name => "DO"}
        %block{:type => "ruby_statement", :x => "0", :y => "0"}
          %field{:name => "STATEMENT"}<
            p self
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    until false
      p self
    end

    """
