# encoding: utf-8
# language: ja
@javascript
機能: ruby_expression - 「式」ブロック
  背景:
    前提 "ブロック" タブを表示する

  シナリオ: ブロックのみ配置する
    もし 次のブロック("ruby_expression")を配置する:
      """
      %block{:type => "ruby_expression", :x => "0", :y => "0", :inline => "true"}
        %field{:name => "EXP"}<
          stage1 = Stage.new(color: "white")
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      (stage1 = Stage.new(color: "white"))
      """

  シナリオ: 文とブロックを配置する
    もし 次のブロック("ruby_expression")を配置する:
      """
      %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true"}
        %value{:name => "ARG"}
          %block{:type => "ruby_expression", :x => "0", :y => "0", :inline => "true"}
            %field{:name => "EXP"}<
              stage1 = Stage.new(color: "white")
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      p((stage1 = Stage.new(color: "white")))
      """
