# encoding: utf-8
# language: en
@javascript
Feature: hardware_smalrubot_s1_ir_photoreflector_value block
  Scenario: ブロックのみ配置する
    Given "ブロック" タブを表示する

    When 次のブロックを配置する:
      """
      %block{:type => "hardware_smalrubot_s1_ir_photoreflector_value", :x => "0", :y => "0"}
        %field{:name => "LOR"}<
          right
      """
    And ブロックからソースコードを生成する

    Then テキストエディタのプログラムは "" であること

  Scenario: 文とブロックを配置する
    Given "ブロック" タブを表示する

    When 次のブロックを配置する:
      """
      %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true" }
        %value{:name => "ARG"}
          %block{:type => "hardware_smalrubot_s1_ir_photoreflector_value", :x => "0", :y => "0"}
            %field{:name => "LOR"}<
              right
      """
    And ブロックからソースコードを生成する

    Then テキストエディタのプログラムは以下であること:
      """
      require "smalruby"

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
              %block{:type => "hardware_smalrubot_s1_ir_photoreflector_value", :x => "0", :y => "0"}
                %field{:name => "LOR"}<
                  right
      """
    And ブロックからソースコードを生成する

    Then テキストエディタのプログラムは以下であること:
      """
      require "smalruby"

      car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)
      p(car1.smalrubot_s1.right_ir_photoreflector_value)

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
                  %block{:type => "hardware_smalrubot_s1_ir_photoreflector_value", :x => "0", :y => "0"}
                    %field{:name => "LOR"}<
                      left
      """
    And ブロックからソースコードを生成する

    Then テキストエディタのプログラムは以下であること:
      """
      require "smalruby"

      car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

      car1.on(:start) do
        p(smalrubot_s1.left_ir_photoreflector_value)
      end

      """
