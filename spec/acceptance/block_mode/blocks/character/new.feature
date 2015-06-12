# encoding: utf-8
# language: ja
@javascript
機能: character_new - 「キャラクター」ブロック
  シナリオ: ブロックのみ配置する
    前提 "ブロック" タブを表示する
    かつ 次のキャラクターを追加する:
      | name | costumes |   x |   y | angle |
      | car1 | car4.png  | 300 | 200 |    90 |

    もし 次のブロックを配置する:
    """
    %block{:type => "character_new", :x => "0", :y => "0"}
      %field{:name => "NAME"}<
        car1
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    car1 = Character.new(costume: "costume1:car4.png", x: 300, y: 200, angle: 90)

    """

  シナリオ: ブロックとその内部にキャラクターの操作ブロックを配置する
    前提 "ブロック" タブを表示する
    かつ 次のキャラクターを追加する:
      | name | costumes |   x |   y | angle |
      | car1 | car4.png  | 300 | 200 |    90 |

    もし 次のブロックを配置する:
    """
    %block{:type => "character_new", :x => "0", :y => "0"}
      %field{:name => "NAME"}<
        car1
      %statement{:name => "DO"}
        %block{:type => "motion_move", :x => "0", :y => "0"}
          %value{:name => "STEP"}
            %block{:type => "math_number"}
              %field{:name => "NUM"}<
                10
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    car1 = Character.new(costume: "costume1:car4.png", x: 300, y: 200, angle: 90)
    car1.move(10)

    """

  シナリオ: 複数のブロックとその内部にキャラクターの操作ブロックを配置する
    前提 "ブロック" タブを表示する
    かつ 次のキャラクターを追加する:
      | name | costumes |   x |   y | angle |
      | car1 | car4.png  | 300 | 200 |    90 |

    もし 次のブロックを配置する:
    """
    %block{:type => "character_new", :x => "0", :y => "0"}
      %field{:name => "NAME"}<
        car1
      %statement{:name => "DO"}
        %block{:type => "motion_move", :x => "0", :y => "0"}
          %value{:name => "STEP"}
            %block{:type => "math_number"}
              %field{:name => "NUM"}<
                10
    %block{:type => "character_new", :x => "0", :y => "30"}
      %field{:name => "NAME"}<
        car1
      %statement{:name => "DO"}
        %block{:type => "motion_move", :x => "0", :y => "0"}
          %value{:name => "STEP"}
            %block{:type => "math_number"}
              %field{:name => "NUM"}<
                5
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    car1 = Character.new(costume: "costume1:car4.png", x: 300, y: 200, angle: 90)
    car1.move(10)

    car1.move(5)

    """

  シナリオ: 複数のキャラクターのブロックとその内部にキャラクターの操作ブロックを配置する
    前提 "ブロック" タブを表示する
    かつ 次のキャラクターを追加する:
      | name | costumes |   x |   y | angle |
      | car1 | car4.png | 300 | 200 |    90 |
      | cat1 | cat2.png | 100 | 400 |   180 |

    もし 次のブロックを配置する:
    """
    %block{:type => "character_new", :x => "0", :y => "0"}
      %field{:name => "NAME"}<
        car1
      %statement{:name => "DO"}
        %block{:type => "motion_move", :x => "0", :y => "0"}
          %value{:name => "STEP"}
            %block{:type => "math_number"}
              %field{:name => "NUM"}<
                10
    %block{:type => "character_new", :x => "0", :y => "30"}
      %field{:name => "NAME"}<
        cat1
      %statement{:name => "DO"}
        %block{:type => "motion_move", :x => "0", :y => "0"}
          %value{:name => "STEP"}
            %block{:type => "math_number"}
              %field{:name => "NUM"}<
                5
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    car1 = Character.new(costume: "costume1:car4.png", x: 300, y: 200, angle: 90)
    cat1 = Character.new(costume: "costume1:cat2.png", x: 100, y: 400, angle: 180)
    car1.move(10)

    cat1.move(5)

    """
