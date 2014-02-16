# encoding: utf-8
# language: ja
@javascript
機能: operators_negate - 「条件:<　>ではない」ブロック
  背景:
    前提 "ブロック" タブを表示する

  シナリオ: ブロックのみ配置する
    もし 次のブロック("operators_negate")を配置する:
      """
      %block{:type => "operators_negate", :x => "0", :y => "0", :inline => "true"}
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      !true
      """

  シナリオ: 値を設定したブロックを配置する
    もし 次のブロック("operators_negate")を配置する:
      """
      %block{:type => "operators_negate", :x => "0", :y => "0", :inline => "true"}
        %value{:name => "A"}
          %block{:type => "operators_false"}
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      !false
      """

    もし 次のブロック("operators_negate")を配置する:
      """
      %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true"}
        %value{:name => "ARG"}
          %block{:type => "operators_negate"}
            %value{:name => "A"}
              %block{:type => "operators_false"}
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      p(!false)
      """
