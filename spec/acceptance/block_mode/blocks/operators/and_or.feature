# encoding: utf-8
# language: ja
@javascript
機能: operators_{and,or} - 「条件:<　> {かつ,または} <　>」ブロック
  背景:
    前提 "ブロック" タブを表示する

  シナリオテンプレート: ブロックのみ配置する
    もし 次のブロック("operators_<ブロック名のサフィックス>")を配置する:
      """
      %block{:type => "operators_<ブロック名のサフィックス>", :x => "0", :y => "0", :inline => "true"}
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      <Ruby>
      """

    例:
      | ブロック名のサフィックス | Ruby           |
      | and                      | true && true   |
      | or                       | true \|\| true |

  シナリオテンプレート: 値を設定したブロックを配置する
    もし 次のブロック("operators_<ブロック名のサフィックス>")を配置する:
      """
      %block{:type => "operators_<ブロック名のサフィックス>", :x => "0", :y => "0", :inline => "true"}
        %value{:name => "A"}
          %block{:type => "operators_false"}
        %value{:name => "B"}
          %block{:type => "operators_false"}
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      false <operator> false
      """

    もし 次のブロック("operators_<ブロック名のサフィックス>")を配置する:
      """
      %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true"}
        %value{:name => "ARG"}
          %block{:type => "operators_<ブロック名のサフィックス>"}
            %value{:name => "A"}
              %block{:type => "operators_false"}
            %value{:name => "B"}
              %block{:type => "operators_false"}
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      p(false <operator> false)
      """

    例:
      | ブロック名のサフィックス | operator |
      | and                      | &&       |
      | or                       | \|\|     |
