# encoding: utf-8
# language: ja
@javascript
機能: hardware_two_wheel_drive_car_{speed,set_speed} - 「2WD車[▼PIN]の[▼LOR]の{速度%,速度を<SPEED>%にする}」ブロック
  背景:
    前提 "ブロック" タブを表示する
    かつ 次のキャラクターを追加する:
      | name | costumes | x | y | angle |
      | car1 | car1.png | 0 | 0 |     0 |

  シナリオ: ブロックのみ、キャラクターとブロック、キャラクターとイベントとブロックをそれぞれ配置する
    # ブロックのみ配置する
    もし 次のブロック("two_wheel_drive_car_{speed,set_speed}")を配置する:
      """
      %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true" }
        %value{:name => "ARG"}
          %block{:type => "hardware_two_wheel_drive_car_speed"}
            %field{:name => "PIN"}<
              D5
            %field{:name => "LOR"}<
              left
        %next
          %block{:type => "hardware_two_wheel_drive_car_set_speed"}
            %field{:name => "PIN"}<
              D5
            %field{:name => "LOR"}<
              left
            %value{:name => "SPEED"}
              %block{:type => "math_number"}
                %field{:name => "NUM"}<
                  50
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下であること:
      """
      require "smalruby"

      init_hardware

      p("")

      """

    # キャラクターとブロックを配置する
    もし 次のブロック("hardware_two_wheel_drive_car_{speed,set_speed}")を配置する:
      """
      %block{:type => "character_new", :x => "21", :y => "15"}
        %field{:name => "NAME"}<
          car1
        %statement{:name => "DO"}
          %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true" }
            %value{:name => "ARG"}
              %block{:type => "hardware_two_wheel_drive_car_speed"}
                %field{:name => "PIN"}<
                  D5
                %field{:name => "LOR"}<
                  left
            %next
              %block{:type => "hardware_two_wheel_drive_car_set_speed"}
                %field{:name => "PIN"}<
                  D5
                %field{:name => "LOR"}<
                  left
                %value{:name => "SPEED"}
                  %block{:type => "math_number"}
                    %field{:name => "NUM"}<
                      50
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      p(car1.two_wheel_drive_car("D5").left_speed)
      car1.two_wheel_drive_car("D5").left_speed = 50
      """

    # キャラクターとイベントとブロックを配置する
    もし 次のブロック("hardware_two_wheel_drive_car_{speed,set_speed}")を配置する:
      """
      %block{:type => "character_new", :x => "21", :y => "15"}
        %field{:name => "NAME"}<
          car1
        %statement{:name => "DO"}
          %block{:type => "events_on_start"}
            %statement{:name => "DO"}
              %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true" }
                %value{:name => "ARG"}
                  %block{:type => "hardware_two_wheel_drive_car_speed"}
                    %field{:name => "PIN"}<
                      D5
                    %field{:name => "LOR"}<
                      right
                %next
                  %block{:type => "hardware_two_wheel_drive_car_set_speed"}
                    %field{:name => "PIN"}<
                      D5
                    %field{:name => "LOR"}<
                      right
                    %value{:name => "SPEED"}
                      %block{:type => "math_number"}
                        %field{:name => "NUM"}<
                          50
      """
    かつ ブロックからソースコードを生成する

    ならば テキストエディタのプログラムは以下を含むこと:
      """
      car1.on(:start) do
        p(two_wheel_drive_car("D5").right_speed)
        two_wheel_drive_car("D5").right_speed = 50
      end
      """
