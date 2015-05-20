# encoding: utf-8
# language: ja
@javascript
機能: hardware_rgb_led_turn_off block
  背景:
    前提 "ブロック" タブを表示する
    かつ キャラクターcar1を追加する

  シナリオ: ブロックのみ配置する
    もし 次のブロックを配置する:
      """
      %block{:type => "hardware_rgb_led_turn_off", :x => "0", :y => "0"}
        %field{:name => "AC"}<
          anode
        %field{:name => "PIN"}<
          D3
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
      """
      require "smalruby"

      init_hardware

      """

  シナリオ: キャラクターとブロックを配置する
    もし 次のブロックを配置する:
      """
      %block{:type => "character_new", :x => "21", :y => "15"}
        %field{:name => "NAME"}<
          car1
        %statement{:name => "DO"}
          %block{:type => "hardware_rgb_led_turn_off", :x => "0", :y => "0"}
            %field{:name => "AC"}<
              anode
            %field{:name => "PIN"}<
              D3
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      car1.rgb_led_anode("D3").turn_off
      """

  シナリオ: キャラクターとイベントとブロックを配置する
    もし 次のブロックを配置する:
      """
      %block{:type => "character_new", :x => "21", :y => "15"}
        %field{:name => "NAME"}<
          car1
        %statement{:name => "DO"}
          %block{:type => "events_on_start"}
            %statement{:name => "DO"}
              %block{:type => "hardware_rgb_led_turn_off", :x => "0", :y => "0"}
                %field{:name => "AC"}<
                  anode
                %field{:name => "PIN"}<
                  D3
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      car1.on(:start) do
        rgb_led_anode("D3").turn_off
      end
      """
