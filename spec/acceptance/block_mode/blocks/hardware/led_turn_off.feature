# encoding: utf-8
# language: ja
@javascript
機能: hardware_led_turn_off block
  背景:
    前提 "ブロック" タブを表示する
    かつ キャラクターcar1を追加する

  シナリオ: ブロックのみ配置する
    もし 次のブロックを配置する:
      """
      %block{:type => "hardware_led_turn_off", :x => "0", :y => "0"}
        %field{:name => "PIN"}<
          D13
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは "" であること

  シナリオ: キャラクターとブロックを配置する
    もし 次のブロックを配置する:
      """
      %block{:type => "character_new", :x => "21", :y => "15"}
        %field{:name => "NAME"}<
          car1
        %statement{:name => "DO"}
          %block{:type => "hardware_led_turn_off", :x => "0", :y => "0"}
            %field{:name => "PIN"}<
              D13
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
      """
      require "smalruby"

      car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)
      car1.led("D13").turn_off

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
              %block{:type => "hardware_led_turn_off", :x => "0", :y => "0"}
                %field{:name => "PIN"}<
                  D13
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
      """
      require "smalruby"

      car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

      car1.on(:start) do
        led("D13").turn_off
      end

      """
