# encoding: utf-8
# language: ja
@javascript
機能: operators_modulo - 「変数:(　)を(　)で割った余り」ブロック
  背景:
    前提 "ブロック" タブを表示する

  シナリオ: ブロックのみ配置する
    もし 次のブロックを配置する:
    """
    %block{:type => "operators_modulo", :x => "0", :y => "0"}
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      1 % 1
      """

  シナリオ: 値を設定したブロックを配置する
    もし 次のブロックを配置する:
    """
    %block{:type => "operators_modulo", :x => "0", :y => "0"}
      %value{:name => "A"}
        %block{:type => "math_number"}
          %field{:name => "NUM"}<
            5
      %value{:name => "B"}
        %block{:type => "math_number"}
          %field{:name => "NUM"}<
            2
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      5 % 2
      """

  シナリオ: 文と値を設定したブロックを配置する
    もし 次のブロックを配置する:
    """
    %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true"}
      %value{:name => "ARG"}
        %block{:type => "operators_modulo"}
          %value{:name => "A"}
            %block{:type => "math_number"}
              %field{:name => "NUM"}<
                5
          %value{:name => "B"}
            %block{:type => "math_number"}
              %field{:name => "NUM"}<
                2
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      p(5 % 2)
      """
