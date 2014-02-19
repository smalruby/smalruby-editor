# encoding: utf-8
# language: ja
@javascript
機能: control_loop - 「ずっと」ブロック
  背景:
    前提 "ブロック" タブを表示する
    かつ 次のキャラクターを追加する:
      | name | costumes | x | y | angle |
      | car1 | car1.png | 0 | 0 |     0 |

  シナリオ: ブロックのみ配置する
    もし 次のブロックを配置する:
      """
      %block{:type => "control_loop", :x => "0", :y => "0"}
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは "" であること

  シナリオ: ブロックとその内側に文を配置する
    もし 次のブロックを配置する:
      """
      %block{:type => "control_loop", :x => "0", :y => "0"}
        %statement{:name => "DO"}
          %block{:type => "ruby_statement", :x => "0", :y => "0"}
            %field{:name => "STATEMENT"}<
              p self
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは "" であること

  シナリオ: ブロックとその内側に文を配置する
    もし 次のブロックを配置する:
      """
      %block{:type => "control_loop", :x => "0", :y => "0"}
        %statement{:name => "DO"}
          %block{:type => "ruby_statement", :x => "0", :y => "0"}
            %field{:name => "STATEMENT"}<
              p self
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは "" であること

  シナリオ: キャラクターと文とブロックを配置する
    もし 次のブロックを配置する:
      """
      %block{:type => "character_new", :x => "21", :y => "15"}
        %field{:name => "NAME"}<
          car1
        %statement{:name => "DO"}
          %block{:type => "control_loop", :x => "0", :y => "0"}
            %statement{:name => "DO"}
              %block{:type => "ruby_statement", :x => "0", :y => "0"}
                %field{:name => "STATEMENT"}<
                  p self
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含まないこと:
      """
      loop do
        p self
      end
      """

  シナリオ: キャラクターとイベントと文とブロックを配置する
    もし 次のブロックを配置する:
      """
      %block{:type => "character_new", :x => "21", :y => "15"}
        %field{:name => "NAME"}<
          car1
        %statement{:name => "DO"}
          %block{:type => "events_on_start"}
            %statement{:name => "DO"}
              %block{:type => "control_loop", :x => "0", :y => "0"}
                %statement{:name => "DO"}
                  %block{:type => "ruby_statement", :x => "0", :y => "0"}
                    %field{:name => "STATEMENT"}<
                      p self
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      car1.on(:start) do
        loop do
          p self
        end
      end

      """
