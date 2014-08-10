# encoding: utf-8
# language: ja
@javascript
機能: hardware_button_not_use_pullup - 「ボタン[▼PIN]のプルアップ抵抗を使わない」ブロック
  背景:
    前提 "ブロック" タブを表示する
    かつ 次のキャラクターを追加する:
      | name | costumes | x | y | angle |
      | car1 | car1.png | 0 | 0 |     0 |

  シナリオ: ブロックのみ、キャラクターとブロック、キャラクターとイベントとブロックをそれぞれ配置する
    # ブロックのみ配置する
    もし 次のブロック("hardware_button_not_use_pullup")を配置する:
      """
      %block{:type => "hardware_button_not_use_pullup"}
        %field{:name => "PIN"}<
          D3
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは "" であること

    # キャラクターとブロックを配置する
    もし 次のブロック("hardware_hardware_button_not_use_pullup")を配置する:
      """
      %block{:type => "character_new", :x => "21", :y => "15"}
        %field{:name => "NAME"}<
          car1
        %statement{:name => "DO"}
          %block{:type => "hardware_button_not_use_pullup"}
            %field{:name => "PIN"}<
              D3
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      car1.button("D3").not_use_pullup
      """

    # キャラクターとイベントとブロックを配置する
    もし 次のブロック("hardware_hardware_button_not_use_pullup")を配置する:
      """
      %block{:type => "character_new", :x => "21", :y => "15"}
        %field{:name => "NAME"}<
          car1
        %statement{:name => "DO"}
          %block{:type => "events_on_start"}
            %statement{:name => "DO"}
              %block{:type => "hardware_button_not_use_pullup"}
                %field{:name => "PIN"}<
                  D3
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      car1.on(:start) do
        button("D3").not_use_pullup
      end
      """
