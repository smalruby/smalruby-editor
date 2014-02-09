# encoding: utf-8
# language: ja
@javascript
機能: control_if_else - 「もし<　>なら～でなければ」ブロック
  シナリオ: ブロックのみ配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "control_if_else", :x => "0", :y => "0"}
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    if false

    else

    end

    """

  シナリオ: 値を設定したブロックを配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "control_if_else", :x => "0", :y => "0"}
      %value{:name => "COND"}
        %block{:type => "operators_true"}
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    if true

    else

    end

    """

  シナリオ: ブロックとその内部に文を配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "control_if_else", :x => "0", :y => "0"}
      %value{:name => "COND"}
        %block{:type => "operators_true"}
      %statement{:name => "THEN"}
        %block{:type => "ruby_statement", :x => "0", :y => "0"}
          %field{:name => "STATEMENT"}<
            p self
      %statement{:name => "ELSE"}
        %block{:type => "ruby_statement", :x => "0", :y => "0"}
          %field{:name => "STATEMENT"}<
            p self.class
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    if true
      p self
    else
      p self.class
    end

    """
