# encoding: utf-8
# language: ja
@javascript
機能: hardware_servo_set_position - 「サーボ[▼ピン]を(　)度(5～180)にする」ブロック
  背景:
    前提 "ブロック" タブを表示する
    かつ 次のキャラクターを追加する:
      | name | costumes | x | y | angle |
      | car1 | car1.png | 0 | 0 |     0 |

  シナリオ: ブロックのみ配置する
    もし 次のブロックを配置する:
    """
    %block{:type => "hardware_servo_set_position", :x => "0", :y => "0"}
      %field{:name => "PIN"}<
        D3
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは "" であること

  シナリオ: 値を設定したブロックを配置する
    もし 次のブロックを配置する:
    """
    %block{:type => "hardware_servo_set_position", :x => "0", :y => "0"}
      %field{:name => "PIN"}<
        D3
      %value{:name => "POS"}
        %block{:type => "math_number"}
          %field{:name => "NUM"}<
            5
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
        %block{:type => "hardware_servo_set_position", :x => "0", :y => "0"}
          %field{:name => "PIN"}<
            D3
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
    """
    car1.servo("D3").position = 5

    """

  シナリオ: キャラクターと値を設定したブロックを配置する
    もし 次のブロックを配置する:
    """
    %block{:type => "character_new", :x => "21", :y => "15"}
      %field{:name => "NAME"}<
        car1
      %statement{:name => "DO"}
        %block{:type => "hardware_servo_set_position", :x => "0", :y => "0"}
          %field{:name => "PIN"}<
            D3
          %value{:name => "POS"}
            %block{:type => "math_number"}
              %field{:name => "NUM"}<
                5
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
    """
    car1.servo("D3").position = 5

    """

  シナリオ: キャラクターとイベントと値を設定したブロックを配置する
    もし 次のブロックを配置する:
    """
    %block{:type => "character_new", :x => "21", :y => "15"}
      %field{:name => "NAME"}<
        car1
      %statement{:name => "DO"}
        %block{:type => "events_on_start"}
          %statement{:name => "DO"}
            %block{:type => "hardware_servo_set_position", :x => "0", :y => "0"}
              %field{:name => "PIN"}<
                D3
              %value{:name => "POS"}
                %block{:type => "math_number"}
                  %field{:name => "NUM"}<
                    5
    """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
    """
    car1.on(:start) do
      servo("D3").position = 5
    end

    """
