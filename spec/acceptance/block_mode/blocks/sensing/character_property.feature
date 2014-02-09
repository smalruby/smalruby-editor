# encoding: utf-8
# language: ja
@javascript
機能: sensing_character_property - 「変数:[▼キャラクター]の[▼プロパティ]」ブロック
  シナリオ: ブロックのみ配置する
    前提 "ブロック" タブを表示する
    かつ 次のキャラクターを追加する:
      | name | costumes | x | y | angle |
      | car1 | car1.png | 0 | 0 |     0 |

    もし 次のブロックを配置する:
    """
    %block{:type => "sensing_character_property", :x => "0", :y => "0"}
      %field{:name => "CHAR"}<
        car1
      %field{:name => "PROPERTY"}<
        x
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは "" であること

  シナリオ: 文とブロックを配置する
    前提 "ブロック" タブを表示する
    かつ 次のキャラクターを追加する:
      | name | costumes | x | y | angle |
      | car1 | car1.png | 0 | 0 |     0 |

    もし 次のブロックを配置する:
    """
    %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true" }
      %value{:name => "ARG"}
        %block{:type => "sensing_character_property", :x => "0", :y => "0"}
          %field{:name => "CHAR"}<
            car1
          %field{:name => "PROPERTY"}<
            x
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    p("")

    """

  シナリオ: キャラクターと文とブロックを配置する
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
        %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true" }
          %value{:name => "ARG"}
            %block{:type => "sensing_character_property", :x => "0", :y => "0"}
              %field{:name => "CHAR"}<
                car1
              %field{:name => "PROPERTY"}<
                x
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)
    p(car1.x)

    """

  シナリオ: キャラクターとイベントと文とブロックを配置する
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
            %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true" }
              %value{:name => "ARG"}
                %block{:type => "sensing_character_property", :x => "0", :y => "0"}
                  %field{:name => "CHAR"}<
                    car1
                  %field{:name => "PROPERTY"}<
                    x
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

    car1.on(:start) do
      p(x)
    end

    """
