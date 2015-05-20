# encoding: utf-8
# language: en
@javascript
Feature: hardware_smalrubot_v3_led_turn_on_or_off block
  Background:
    Given "ブロック" タブを表示する
    And キャラクターcar1を追加する

  Scenario: ブロックのみ配置する
    When 次のブロックを配置する:
      """
      %block{:type => "hardware_smalrubot_v3_led_turn_on_or_off", :x => "0", :y => "0"}
        %field{:name => "LOR"}<
          left
        %field{:name => "OOO"}<
          turn_off
      """
    And ブロックからソースコードを生成する

    Then テキストエディタのプログラムは以下であること:
      """
      require "smalruby"

      init_hardware

      """

  Scenario: キャラクターとブロックを配置する
    When 次のブロックを配置する:
      """
      %block{:type => "character_new", :x => "21", :y => "15"}
        %field{:name => "NAME"}<
          car1
        %statement{:name => "DO"}
          %block{:type => "hardware_smalrubot_v3_led_turn_on_or_off", :x => "0", :y => "0"}
            %field{:name => "LOR"}<
              left
            %field{:name => "OOO"}<
              turn_off
      """
    And ブロックからソースコードを生成する

    Then テキストエディタのプログラムは以下を含むこと:
      """
      car1.smalrubot_v3.turn_off_left_led
      """

  Scenario: キャラクターとイベントとブロックを配置する
    When 次のブロックを配置する:
      """
      %block{:type => "character_new", :x => "21", :y => "15"}
        %field{:name => "NAME"}<
          car1
        %statement{:name => "DO"}
          %block{:type => "events_on_start"}
            %statement{:name => "DO"}
              %block{:type => "hardware_smalrubot_v3_led_turn_on_or_off", :x => "0", :y => "0"}
                %field{:name => "LOR"}<
                  right
                %field{:name => "OOO"}<
                  turn_on
      """
    And ブロックからソースコードを生成する

    Then テキストエディタのプログラムは以下を含むこと:
      """
      car1.on(:start) do
        smalrubot_v3.turn_on_right_led
      end
      """
