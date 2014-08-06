# encoding: utf-8
# language: ja
@javascript
機能: hardware_motor_driver - 「（モータードライバで）モーターを{正転させる,逆転させる,止める}」ブロック
  背景:
    前提 "ブロック" タブを表示する
    かつ 次のキャラクターを追加する:
      | name | costumes | x | y | angle |
      | car1 | car1.png | 0 | 0 |     0 |

  シナリオテンプレート: ブロックのみ、キャラクターとブロック、キャラクターとイベントとブロックをそれぞれ配置する
    # ブロックのみ配置する
    もし 次のブロック("motor_driver(<メソッド>)")を配置する:
      """
      %block{:type => "hardware_motor_driver", :x => "0", :y => "0"}
        %field{:name => "PIN"}<
          D3
        %field{:name => "METHOD"}<
          <メソッド>
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは "" であること

    # キャラクターとブロックを配置する
    もし 次のブロック("motor_driver(<メソッド>)")を配置する:
      """
      %block{:type => "character_new", :x => "21", :y => "15"}
        %field{:name => "NAME"}<
          car1
        %statement{:name => "DO"}
          %block{:type => "hardware_motor_driver"}
            %field{:name => "PIN"}<
              D3
            %field{:name => "METHOD"}<
              <メソッド>
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      car1.motor_driver("D3").<メソッド>
      """

    # キャラクターとイベントとブロックを配置する
    もし 次のブロック("motor_driver(<メソッド>)")を配置する:
      """
      %block{:type => "character_new", :x => "21", :y => "15"}
        %field{:name => "NAME"}<
          car1
        %statement{:name => "DO"}
          %block{:type => "events_on_start"}
            %statement{:name => "DO"}
              %block{:type => "hardware_motor_driver"}
                %field{:name => "PIN"}<
                  D3
                %field{:name => "METHOD"}<
                  <メソッド>
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      car1.on(:start) do
        motor_driver("D3").<メソッド>
      end
      """

    例:
      | メソッド |
      | forward  |
      | backward |
      | stop     |
