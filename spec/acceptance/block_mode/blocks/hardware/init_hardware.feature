# encoding: utf-8
# language: ja
@javascript
機能: hardware_init_hardware - 「ハードウェアを準備する」ブロック
  シナリオ: ブロックのみ配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "hardware_init_hardware", :x => "0", :y => "0"}
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    init_hardware

    """

  シナリオ: ブロックとそれ以外のブロックを配置する
    前提 "ブロック" タブを表示する
    かつ 次のキャラクターを追加する:
      | name | costumes | x | y | angle |
      | car1 | car1.png | 0 | 0 |     0 |

    もし 次のブロックを配置する:
    """
    %block{:type => "hardware_init_hardware", :x => "0", :y => "0"}
    %block{:type => "character_new", :x => "21", :y => "15"}
      %field{:name => "NAME"}<
        car1
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    init_hardware

    car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

    """
