# encoding: utf-8
# language: ja
@javascript
機能: text - 「"文章"」ブロック
  背景:
    前提 "ブロック" タブを表示する

  シナリオ: ブロックを配置する
    もし 次のブロック("text")を配置する:
      """
      %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true" }
        %value{:name => "ARG"}
          %block{:type => "text"}
            %field{:name => "TEXT"}<
              こんにちは
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      p("こんにちは")
      """

  シナリオ: ダブルクォーテーションを含む文章を設定したブロックを配置する
    もし 次のブロック("text")を配置する:
      """
      %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true"}
        %value{:name => "ARG"}
          %block{:type => "text"}
            %field{:name => "TEXT"}<
              ""
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      p("\"\"")
      """
