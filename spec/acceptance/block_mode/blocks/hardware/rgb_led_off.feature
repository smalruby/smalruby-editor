# encoding: utf-8
# language: ja
@javascript
機能: hardware_rgb_led_off - 「RGB LED[▼ピン]をオフにする」ブロック
  シナリオ: ブロックのみ配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "hardware_rgb_led_off", :x => "0", :y => "0"}
      %field{:name => "AC"}<
        anode
      %field{:name => "PIN"}<
        D3
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは "" であること

  シナリオ: キャラクターとブロックを配置する
    前提 "ブロック" タブを表示する
    かつ 次のキャラクターを追加する:
      | name | costumes | x | y | angle |
      | car1 | car1.png | 0 | 0 |     0 |

    もし 次のブロックを配置する:
    """
    %block{:type => "character_new", :x => "21", :y => "15"}
      %field{:name => "NAME"}<
        car1
      %statement{:name => "DO"}
        %block{:type => "hardware_rgb_led_off", :x => "0", :y => "0"}
          %field{:name => "AC"}<
            anode
          %field{:name => "PIN"}<
            D3
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)
    car1.rgb_led_anode("D3").off

    """

  シナリオ: キャラクターとイベントとブロックを配置する
    前提 "ブロック" タブを表示する
    かつ 次のキャラクターを追加する:
      | name | costumes | x | y | angle |
      | car1 | car1.png | 0 | 0 |     0 |

    もし 次のブロックを配置する:
    """
    %block{:type => "character_new", :x => "21", :y => "15"}
      %field{:name => "NAME"}<
        car1
      %statement{:name => "DO"}
        %block{:type => "events_on_start"}
          %statement{:name => "DO"}
            %block{:type => "hardware_rgb_led_off", :x => "0", :y => "0"}
              %field{:name => "AC"}<
                anode
              %field{:name => "PIN"}<
                D3
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

    car1.on(:start) do
      rgb_led_anode("D3").off
    end

    """
