# encoding: utf-8
# language: ja
@javascript
機能: sound_play - 「[▼プリセット音声]の音を鳴らす」ブロック
  シナリオ: ブロックのみ配置する
    前提 "ブロック" タブを表示する

    もし 次のブロックを配置する:
    """
    %block{:type => "sound_play", :x => "0", :y => "0"}
      %value{:name => "NAME"}
        %block{:type => "text"}
          %field{:name => "TEXT"}<
            piano_do.wav
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
        %block{:type => "sound_play", :x => "0", :y => "0"}
          %value{:name => "NAME"}
            %block{:type => "text"}
              %field{:name => "TEXT"}<
                piano_do.wav
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)
    car1.play(name: "piano_do.wav")

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
            %block{:type => "sound_play", :x => "0", :y => "0"}
              %value{:name => "NAME"}
                %block{:type => "text"}
                  %field{:name => "TEXT"}<
                    piano_do.wav
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
    """
    require "smalruby"

    car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

    car1.on(:start) do
      play(name: "piano_do.wav")
    end

    """
