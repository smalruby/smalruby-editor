# encoding: utf-8
# language: en
@javascript
Feature: hardware_smalrubot_v3_sensor_value block
  Scenario: ブロックのみ配置する
    Given "ブロック" タブを表示する

    When 次のブロックを配置する:
      """
      %block{:type => "hardware_smalrubot_v3_sensor_value", :x => "0", :y => "0"}
        %field{:name => "LOR"}<
          right
      """
    And ブロックからソースコードを生成する

    Then テキストエディタのプログラムは以下であること:
      """
      require "smalruby"

      init_hardware

      """

  Scenario: 文とブロックを配置する
    Given "ブロック" タブを表示する

    When 次のブロックを配置する:
      """
      %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true" }
        %value{:name => "ARG"}
          %block{:type => "hardware_smalrubot_v3_sensor_value", :x => "0", :y => "0"}
            %field{:name => "LOR"}<
              right
      """
    And ブロックからソースコードを生成する

    Then テキストエディタのプログラムは以下であること:
      """
      require "smalruby"

      init_hardware

      p("")

      """

  Scenario: キャラクターとブロックを配置する
    Given "ブロック" タブを表示する
    And 次のキャラクターを追加する:
      | name | costumes | x | y | angle |
      | car1 | car1.png | 0 | 0 |     0 |

    When 次のブロックを配置する:
      """
      %block{:type => "character_new", :x => "21", :y => "15"}
        %field{:name => "NAME"}<
          car1
        %statement{:name => "DO"}
          %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true" }
            %value{:name => "ARG"}
              %block{:type => "hardware_smalrubot_v3_sensor_value", :x => "0", :y => "0"}
                %field{:name => "LOR"}<
                  right
      """
    And ブロックからソースコードを生成する

    Then テキストエディタのプログラムは以下を含むこと:
      """
      p(car1.smalrubot_v3.right_sensor_value)
      """

  Scenario: キャラクターとイベントとブロックを配置する
    Given "ブロック" タブを表示する
    And 次のキャラクターを追加する:
      | name | costumes | x | y | angle |
      | car1 | car1.png | 0 | 0 |     0 |

    When 次のブロックを配置する:
      """
      %block{:type => "character_new", :x => "21", :y => "15"}
        %field{:name => "NAME"}<
          car1
        %statement{:name => "DO"}
          %block{:type => "events_on_start"}
            %statement{:name => "DO"}
              %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true" }
                %value{:name => "ARG"}
                  %block{:type => "hardware_smalrubot_v3_sensor_value", :x => "0", :y => "0"}
                    %field{:name => "LOR"}<
                      left
      """
    And ブロックからソースコードを生成する

    Then テキストエディタのプログラムは以下を含むこと:
      """
      car1.on(:start) do
        p(smalrubot_v3.left_sensor_value)
      end
      """
