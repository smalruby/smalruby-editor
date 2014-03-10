# encoding: utf-8
# language: ja
@javascript
機能: hardware_two_wheel_drive_car_{forward,backward,turn_left,turn_right,stop} - 「2WD車[▼ピン]を{進める,バックさせる,左に曲げる,右に曲げる,止める}」ブロック
  背景:
    前提 "ブロック" タブを表示する
    かつ 次のキャラクターを追加する:
      | name | costumes | x | y | angle |
      | car1 | car1.png | 0 | 0 |     0 |

  シナリオテンプレート: ブロックのみ、キャラクターとブロック、キャラクターとイベントとブロックをそれぞれ配置する
    # ブロックのみ配置する
    もし 次のブロック("hardware_two_wheel_drive_car_<ブロック名のサフィックス>")を配置する:
      """
      %block{:type => "hardware_two_wheel_drive_car_<ブロック名のサフィックス>", :x => "0", :y => "0"}
        %field{:name => "PIN"}<
          D2
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは "" であること

    # キャラクターとブロックを配置する
    もし 次のブロック("hardware_two_wheel_drive_car_<ブロック名のサフィックス>")を配置する:
      """
      %block{:type => "character_new", :x => "21", :y => "15"}
        %field{:name => "NAME"}<
          car1
        %statement{:name => "DO"}
          %block{:type => "hardware_two_wheel_drive_car_<ブロック名のサフィックス>", :x => "0", :y => "0"}
            %field{:name => "PIN"}<
              D2
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      car1.two_wheel_drive_car("D2").<ブロック名のサフィックス>
      """

    # キャラクターとイベントとブロックを配置する
    もし 次のブロック("hardware_two_wheel_drive_car_<ブロック名のサフィックス>")を配置する:
      """
      %block{:type => "character_new", :x => "21", :y => "15"}
        %field{:name => "NAME"}<
          car1
        %statement{:name => "DO"}
          %block{:type => "events_on_start"}
            %statement{:name => "DO"}
              %block{:type => "hardware_two_wheel_drive_car_<ブロック名のサフィックス>", :x => "0", :y => "0"}
                %field{:name => "PIN"}<
                  D2
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      car1.on(:start) do
        two_wheel_drive_car("D2").<ブロック名のサフィックス>
      end
      """

    例:
      | ブロック名のサフィックス |
      | forward                  |
      | backward                 |
      | turn_left                |
      | turn_right               |
      | stop                     |
