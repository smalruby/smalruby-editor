# encoding: utf-8
# language: ja
@javascript
機能: events_on_hit - 「[▼キャラクター]にぶつかったとき」ブロック
  シナリオ: ブロックのみ配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "events_on_hit", :x => "0", :y => "0"}
      %field{:name => "CHAR"}<
        car2
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは "" であること

  シナリオ: キャラクターとブロックを配置する
    前提 "ブロック" タブを表示する
    かつ 次のキャラクターを追加する:
      | name | costumes | x | y | angle |
      | car1 | car1.png | 0 | 0 |     0 |
      | car2 | car2.png | 0 | 0 |     0 |

    もし 次のブロックを配置する:
    """
    %block{:type => "character_new", :x => "21", :y => "15"}
      %field{:name => "NAME"}<
        car1
      %statement{:name => "DO"}
        %block{:type => "events_on_hit", :x => "0", :y => "0"}
          %field{:name => "CHAR"}<
            car2
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)
    car2 = Character.new(costume: "car2.png", x: 0, y: 0, angle: 0)

    car1.on(:hit, car2) do

    end

    """

  シナリオ: キャラクターとイベントとブロックを配置する
    前提 "ブロック" タブを表示する
    かつ 次のキャラクターを追加する:
      | name | costumes | x | y | angle |
      | car1 | car1.png | 0 | 0 |     0 |
      | car2 | car2.png | 0 | 0 |     0 |

    もし 次のブロックを配置する:
    """
    %block{:type => "character_new", :x => "21", :y => "15"}
      %field{:name => "NAME"}<
        car1
      %statement{:name => "DO"}
        %block{:type => "events_on_start"}
          %statement{:name => "DO"}
            %block{:type => "events_on_hit"}
              %field{:name => "CHAR"}<
                car2
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)
    car2 = Character.new(costume: "car2.png", x: 0, y: 0, angle: 0)

    car1.on(:start) do

      on(:hit, car2) do

      end
    end

    """
