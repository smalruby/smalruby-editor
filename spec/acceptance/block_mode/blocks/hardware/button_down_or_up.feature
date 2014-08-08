# encoding: utf-8
# language: ja
@javascript
機能: hardware_button_down_or_up - 「条件:ボタン[▼PIN]が[▼押された]」ブロック
  背景:
    前提 "ブロック" タブを表示する
    かつ 次のキャラクターを追加する:
      | name | costumes | x | y | angle |
      | car1 | car1.png | 0 | 0 |     0 |

  シナリオ: ブロックのみ、キャラクターとブロック、キャラクターとイベントとブロックをそれぞれ配置する
    # ブロックのみ配置する
    もし 次のブロック("hardware_button_down_or_up")を配置する:
      """
      %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true" }
        %value{:name => "ARG"}
          %block{:type => "hardware_button_down_or_up"}
            %field{:name => "PIN"}<
              D3
            %field{:name => "DOU"}<
              down
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
      """
      require "smalruby"

      p("")

      """

    # キャラクターとブロックを配置する
    もし 次のブロック("hardware_hardware_button_down_or_up")を配置する:
      """
      %block{:type => "character_new", :x => "21", :y => "15"}
        %field{:name => "NAME"}<
          car1
        %statement{:name => "DO"}
          %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true" }
            %value{:name => "ARG"}
              %block{:type => "hardware_button_down_or_up"}
                %field{:name => "PIN"}<
                  D3
                %field{:name => "DOU"}<
                  down
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      p(car1.button("D3").down?)
      """

    # キャラクターとイベントとブロックを配置する
    もし 次のブロック("hardware_hardware_button_down_or_up")を配置する:
      """
      %block{:type => "character_new", :x => "21", :y => "15"}
        %field{:name => "NAME"}<
          car1
        %statement{:name => "DO"}
          %block{:type => "events_on_start"}
            %statement{:name => "DO"}
              %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true" }
                %value{:name => "ARG"}
                  %block{:type => "hardware_button_down_or_up"}
                    %field{:name => "PIN"}<
                      D3
                    %field{:name => "DOU"}<
                      up
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      car1.on(:start) do
        p(button("D3").up?)
      end
      """
