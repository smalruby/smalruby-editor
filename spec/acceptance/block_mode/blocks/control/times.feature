# encoding: utf-8
# language: ja
@javascript
機能: control_times - 「(　)回繰り返す」ブロック
  シナリオ: ブロックのみ配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "control_times", :x => "0", :y => "0"}
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    0.times do

    end

    """

  シナリオ: 値を設定したブロックを配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "control_times", :x => "0", :y => "0"}
      %value{:name => "COUNT"}
        %block{:type => "math_number"}
          %field{:name => "NUM"}<
            10
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    10.times do

    end

    """

  シナリオ: ブロックとその内側に文を配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "control_times", :x => "0", :y => "0"}
      %value{:name => "COUNT"}
        %block{:type => "math_number"}
          %field{:name => "NUM"}<
            10
      %statement{:name => "DO"}
        %block{:type => "ruby_statement", :x => "0", :y => "0"}
          %field{:name => "STATEMENT"}<
            p self
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    10.times do
      p self
    end

    """
