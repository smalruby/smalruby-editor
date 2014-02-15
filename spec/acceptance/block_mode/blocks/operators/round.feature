# encoding: utf-8
# language: ja
@javascript
機能: operators_round - 「変数:(　)を丸める」ブロック
  背景:
    前提 "ブロック" タブを表示する

  シナリオ: ブロックのみ配置する
    もし 次のブロックを配置する:
    """
    %block{:type => "operators_round", :x => "0", :y => "0"}
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      0.round
      """

  シナリオ: 値を設定したブロックを配置する
    もし 次のブロックを配置する:
    """
    %block{:type => "operators_round", :x => "0", :y => "0"}
      %value{:name => "A"}
        %block{:type => "math_number"}
          %field{:name => "NUM"}<
            0.5
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      0.5.round
      """

  シナリオ: 文と値を設定したブロックを配置する
    もし 次のブロックを配置する:
    """
    %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true"}
      %value{:name => "ARG"}
        %block{:type => "operators_round"}
          %value{:name => "A"}
            %block{:type => "math_number"}
              %field{:name => "NUM"}<
                0.5
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      p(0.5.round)
      """
