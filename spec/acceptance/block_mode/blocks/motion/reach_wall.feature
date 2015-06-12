# encoding: utf-8
# language: ja
@javascript
機能: motion_reach_wall - 「条件:端に触れた」ブロック (後方互換性)
  シナリオ: ブロックのみ配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "motion_reach_wall", :x => "0", :y => "0"}
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは "" であること

  シナリオ: 条件分岐とブロックを配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "control_if", :x => "0", :y => "0", :inline => "true"}
      %value{:name => "COND"}
        %block{:type => "motion_reach_wall"}
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    if false

    end

    """

  シナリオ: キャラクターと条件分岐とブロックを配置する
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
        %block{:type => "control_if", :x => "0", :y => "0", :inline => "true"}
          %value{:name => "COND"}
            %block{:type => "motion_reach_wall"}
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    car1 = Character.new(costume: "costume1:car1.png", x: 0, y: 0, angle: 0)
    if car1.reach_wall?

    end

    """

  シナリオ: キャラクターとイベントと条件分岐とブロックを配置する
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
            %block{:type => "control_if", :x => "0", :y => "0", :inline => "true"}
              %value{:name => "COND"}
                %block{:type => "motion_reach_wall"}
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    car1 = Character.new(costume: "costume1:car1.png", x: 0, y: 0, angle: 0)

    car1.on(:start) do
      if reach_wall?

      end
    end

    """
