# encoding: utf-8
# language: ja
@javascript
機能: operators_rand - 「変数:(　)から(　)までの乱数」ブロック
  背景:
    前提 "ブロック" タブを表示する

  シナリオ: ブロックのみ配置する
    もし 次のブロックを配置する:
    """
    %block{:type => "operators_rand", :x => "0", :y => "0"}
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      rand(0..0)
      """

  シナリオ: 値を設定したブロックを配置する
    もし 次のブロックを配置する:
    """
    %block{:type => "operators_rand", :x => "0", :y => "0"}
      %value{:name => "A"}
        %block{:type => "math_number"}
          %field{:name => "NUM"}<
            1
      %value{:name => "B"}
        %block{:type => "math_number"}
          %field{:name => "NUM"}<
            10
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      rand(1..10)
      """

  シナリオ: 文と値を設定したブロックを配置する
    もし 次のブロックを配置する:
    """
    %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true"}
      %value{:name => "ARG"}
        %block{:type => "operators_rand"}
          %value{:name => "A"}
            %block{:type => "math_number"}
              %field{:name => "NUM"}<
                1
          %value{:name => "B"}
            %block{:type => "math_number"}
              %field{:name => "NUM"}<
                10
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      p(rand(1..10))
      """
