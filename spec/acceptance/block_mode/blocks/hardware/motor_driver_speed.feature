# encoding: utf-8
# language: ja
@javascript
機能: hardware_motor_driver_{speed,set_speed} - 「（モータードライバの）モーターの{速度,速度を＜速度の割合＞にする}」ブロック
  背景:
    前提 "ブロック" タブを表示する
    かつ 次のキャラクターを追加する:
      | name | costumes | x | y | angle |
      | car1 | car1.png | 0 | 0 |     0 |

  シナリオ: ブロックのみ、キャラクターとブロック、キャラクターとイベントとブロックをそれぞれ配置する
    # ブロックのみ配置する
    もし 次のブロック("motor_driver_{speed,set_speed}")を配置する:
      """
      %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true" }
        %value{:name => "ARG"}
          %block{:type => "hardware_motor_driver_speed"}
            %field{:name => "PIN"}<
              D3
        %next
          %block{:type => "hardware_motor_driver_set_speed"}
            %value{:name => "SPEED"}
              %block{:type => "math_number"}
                %field{:name => "NUM"}<
                  50
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
      """
      require "smalruby"

      p("")

      """

    # キャラクターとブロックを配置する
    もし 次のブロック("hardware_motor_driver_{speed,set_speed}")を配置する:
      """
      %block{:type => "character_new", :x => "21", :y => "15"}
        %field{:name => "NAME"}<
          car1
        %statement{:name => "DO"}
          %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true" }
            %value{:name => "ARG"}
              %block{:type => "hardware_motor_driver_speed"}
                %field{:name => "PIN"}<
                  D3
            %next
              %block{:type => "hardware_motor_driver_set_speed"}
                %value{:name => "SPEED"}
                  %block{:type => "math_number"}
                    %field{:name => "NUM"}<
                      50
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      p(car1.motor_driver("D3").speed)
      car1.motor_driver("D3").speed = 50
      """

    # キャラクターとイベントとブロックを配置する
    もし 次のブロック("hardware_motor_driver_{speed,set_speed}")を配置する:
      """
      %block{:type => "character_new", :x => "21", :y => "15"}
        %field{:name => "NAME"}<
          car1
        %statement{:name => "DO"}
          %block{:type => "events_on_start"}
            %statement{:name => "DO"}
              %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true" }
                %value{:name => "ARG"}
                  %block{:type => "hardware_motor_driver_speed"}
                    %field{:name => "PIN"}<
                      D3
                %next
                  %block{:type => "hardware_motor_driver_set_speed"}
                    %value{:name => "SPEED"}
                      %block{:type => "math_number"}
                        %field{:name => "NUM"}<
                          50
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      car1.on(:start) do
        p(motor_driver("D3").speed)
        motor_driver("D3").speed = 50
      end
      """
