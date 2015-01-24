# encoding: utf-8
# language: ja
@javascript
機能: hardware_rgb_led_set_color block
  背景:
    前提 "ブロック" タブを表示する
    かつ キャラクターcar1を追加する

  シナリオ: ブロックのみ配置する
    もし 次のブロックを配置する:
      """
      %block{:type => "hardware_rgb_led_set_color", :x => "0", :y => "0"}
        %field{:name => "AC"}<
          anode
        %field{:name => "PIN"}<
          D3
        %field{:name => "COLOUR"}<
          \#808080
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
          %block{:type => "hardware_rgb_led_set_color", :x => "0", :y => "0"}
            %field{:name => "AC"}<
              anode
            %field{:name => "PIN"}<
              D3
            %field{:name => "COLOUR"}<
              \#808080
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
      """
      require "smalruby"

      car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)
      car1.rgb_led_anode("D3").color = [128, 128, 128]

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
              %block{:type => "hardware_rgb_led_set_color", :x => "0", :y => "0"}
                %field{:name => "AC"}<
                  anode
                %field{:name => "PIN"}<
                  D3
                %field{:name => "COLOUR"}<
                  \#808080
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
      """
      require "smalruby"

      car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

      car1.on(:start) do
        self.rgb_led_anode("D3").color = [128, 128, 128]
      end

      """
