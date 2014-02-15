# encoding: utf-8
# language: ja
@javascript
機能: operators_index_of - 「変数:(　)の(　)番目」ブロック
  背景:
    前提 "ブロック" タブを表示する

  シナリオ: ブロックのみ配置する
    もし 次のブロックを配置する:
    """
    %block{:type => "operators_index_of", :x => "0", :y => "0"}
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      ""[0]
      """

  シナリオ: 値を設定したブロックを配置する
    もし 次のブロックを配置する:
    """
    %block{:type => "operators_index_of", :x => "0", :y => "0"}
      %value{:name => "A"}
        %block{:type => "text"}
          %field{:name => "TEXT"}<
            こんにちは
      %value{:name => "INDEX"}
        %block{:type => "math_number"}
          %field{:name => "NUM"}<
            2
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      "こんにちは"[2]
      """

  シナリオ: 文と値を設定したブロックを配置する
    もし 次のブロックを配置する:
    """
    %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true"}
      %value{:name => "ARG"}
        %block{:type => "operators_index_of"}
          %value{:name => "A"}
            %block{:type => "text"}
              %field{:name => "TEXT"}<
                こんにちは
          %value{:name => "INDEX"}
            %block{:type => "math_number"}
              %field{:name => "NUM"}<
                2
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      p("こんにちは"[2])
      """
