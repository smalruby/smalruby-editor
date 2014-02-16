# encoding: utf-8
# language: ja
@javascript
機能: operators_{add,minus,multiply,divide}, operators_compare_{lt,lte,eq,gte,gt} - 「変数:(　) {+,-,*,/} (　)」「変数:(　) {<,<=,==,>=,>} (　)」ブロック
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
      | ブロック名のサフィックス | Ruby  |
      | add                      | 0 + 0 |
      | minus                    | 0 - 0 |
      | multiply                 | 0 * 0 |
      | divide                   | 0 / 1 |
      | modulo                   | 1 % 1   |
      | compare_lt               | 0 < 0  |
      | compare_lte              | 0 <= 0 |
      | compare_eq               | 0 == 0 |
      | compare_gte              | 0 >= 0 |
      | compare_gt               | 0 > 0  |

  シナリオテンプレート: 値を設定したブロックを配置する
    もし 次のブロック("operators_<ブロック名のサフィックス>")を配置する:
      """
      %block{:type => "operators_<ブロック名のサフィックス>", :x => "0", :y => "0", :inline => "true"}
        %value{:name => "A"}
          %block{:type => "math_number"}
            %field{:name => "NUM"}<
              10
        %value{:name => "B"}
          %block{:type => "math_number"}
            %field{:name => "NUM"}<
              5
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      10 <operator> 5
      """

    例:
      | ブロック名のサフィックス | operator |
      | add                      | +        |
      | minus                    | -        |
      | multiply                 | *        |
      | divide                   | /        |
      | modulo                   | %        |
      | compare_lt               | <        |
      | compare_lte              | <=       |
      | compare_eq               | ==       |
      | compare_gte              | >=       |
      | compare_gt               | >        |

  シナリオテンプレート: 文と値を設定したブロックを配置する
    もし 次のブロック("operators_<ブロック名のサフィックス>")を配置する:
      """
      %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true"}
        %value{:name => "ARG"}
          %block{:type => "operators_<ブロック名のサフィックス>"}
            %value{:name => "A"}
              %block{:type => "math_number"}
                %field{:name => "NUM"}<
                  10
            %value{:name => "B"}
              %block{:type => "math_number"}
                %field{:name => "NUM"}<
                  5
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      p(10 <operator> 5)
      """

    例:
      | ブロック名のサフィックス | operator |
      | add                      | +        |
      | minus                    | -        |
      | multiply                 | *        |
      | divide                   | /        |
      | modulo                   | %        |
      | compare_lt               | <        |
      | compare_lte              | <=       |
      | compare_eq               | ==       |
      | compare_gte              | >=       |
      | compare_gt               | >        |
