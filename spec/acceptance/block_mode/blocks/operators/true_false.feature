# encoding: utf-8
# language: ja
@javascript
機能: operators_{true,false} - 「条件:{真,偽}」ブロック
  背景:
    前提 "ブロック" タブを表示する

  シナリオテンプレート: ブロックを配置する
    もし 次のブロック("operators_<ブロック名のサフィックス>")を配置する:
      """
      %block{:type => "operators_<ブロック名のサフィックス>", :x => "0", :y => "0", :inline => "true"}
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      <Ruby>
      """

    もし 次のブロック("operators_<ブロック名のサフィックス>")を配置する:
      """
      %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true"}
        %value{:name => "ARG"}
          %block{:type => "operators_<ブロック名のサフィックス>"}
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      p(<Ruby>)
      """

    例:
      | ブロック名のサフィックス | Ruby  |
      | true                     | true  |
      | false                    | false |
