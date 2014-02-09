# encoding: utf-8
# language: ja
@javascript
機能: events_on_key_push_or_down - 「キーボードの[▼キー]が[▼押された]とき」ブロック
  シナリオ: [▼押された]ブロックのみ配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "events_on_key_push_or_down", :x => "0", :y => "0"}
      %field{:name => "KEY"}<
        K_SPACE
      %field{:name => "POD"}<
        push
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは "" であること

  シナリオ: キャラクターと[▼押された]ブロックを配置する
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
        %block{:type => "events_on_key_push_or_down", :x => "0", :y => "0"}
          %field{:name => "KEY"}<
            K_SPACE
          %field{:name => "POD"}<
            push
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

    car1.on(:key_push, K_SPACE) do

    end

    """

  シナリオ: キャラクターとイベントと[▼押された]ブロックを配置する
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
            %block{:type => "events_on_key_push_or_down", :x => "0", :y => "0"}
              %field{:name => "KEY"}<
                K_SPACE
              %field{:name => "POD"}<
                push
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

    car1.on(:start) do

      on(:key_push, K_SPACE) do

      end
    end

    """

  シナリオ: [▼押され続けている]ブロックのみ配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "events_on_key_push_or_down", :x => "0", :y => "0"}
      %field{:name => "KEY"}<
        K_SPACE
      %field{:name => "POD"}<
        down
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは "" であること

  シナリオ: キャラクターと[▼押され続けている]ブロックを配置する
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
        %block{:type => "events_on_key_push_or_down", :x => "0", :y => "0"}
          %field{:name => "KEY"}<
            K_SPACE
          %field{:name => "POD"}<
            down
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

    car1.on(:key_down, K_SPACE) do

    end

    """

  シナリオ: キャラクターとイベントと[▼押され続けている]ブロックを配置する
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
            %block{:type => "events_on_key_push_or_down", :x => "0", :y => "0"}
              %field{:name => "KEY"}<
                K_SPACE
              %field{:name => "POD"}<
                down
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

    car1.on(:start) do

      on(:key_down, K_SPACE) do

      end
    end

    """
