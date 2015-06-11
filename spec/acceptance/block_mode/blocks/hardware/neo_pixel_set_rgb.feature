# encoding: utf-8
# language: ja
@javascript
機能: hardware_neo_pixel_set_rgb block
  背景:
    前提 "ブロック" タブを表示する
    かつ キャラクターcar1を追加する

  シナリオ: ブロックのみ配置する
    もし 次のブロックを配置する:
      """
      %block{:type => "hardware_neo_pixel_set_rgb", :x => "0", :y => "0"}
        %field{:name => "PIN"}<
          D5
        %value{:name => "RED"}
          %block{:type => "math_number"}
            %field{:name => "NUM"}<
              0
        %value{:name => "GREEN"}
          %block{:type => "math_number"}
            %field{:name => "NUM"}<
              128
        %value{:name => "BLUE"}
          %block{:type => "math_number"}
            %field{:name => "NUM"}<
              255
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
          %block{:type => "hardware_neo_pixel_set_rgb", :x => "0", :y => "0"}
            %field{:name => "PIN"}<
              D5
            %value{:name => "RED"}
              %block{:type => "math_number"}
                %field{:name => "NUM"}<
                  0
            %value{:name => "GREEN"}
              %block{:type => "math_number"}
                %field{:name => "NUM"}<
                  128
            %value{:name => "BLUE"}
              %block{:type => "math_number"}
                %field{:name => "NUM"}<
                  255
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      car1.neo_pixel("D5").set(color: [0, 128, 255])
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
              %block{:type => "hardware_neo_pixel_set_rgb", :x => "0", :y => "0"}
                %field{:name => "PIN"}<
                  D5
                %value{:name => "RED"}
                  %block{:type => "math_number"}
                    %field{:name => "NUM"}<
                      0
                %value{:name => "GREEN"}
                  %block{:type => "math_number"}
                    %field{:name => "NUM"}<
                      128
                %value{:name => "BLUE"}
                  %block{:type => "math_number"}
                    %field{:name => "NUM"}<
                      255
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      car1.on(:start) do
        neo_pixel("D5").set(color: [0, 128, 255])
      end
      """
