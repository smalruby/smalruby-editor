# encoding: utf-8
# language: en
@javascript
Feature: hardware_smalrubot_s1_led_turn_on_or_off block
  Background:
    Given "ブロック" タブを表示する
    And キャラクターcar1を追加する

  Scenario: ブロックのみ配置する
    When 次のブロックを配置する:
      """
      %block{:type => "hardware_smalrubot_s1_led_turn_on_or_off", :x => "0", :y => "0"}
        %field{:name => "COLOUR"}<
          white
        %field{:name => "OOO"}<
          turn_off
      """
    And ブロックからソースコードを生成する

    Then テキストエディタのプログラムは "" であること

  Scenario: キャラクターとブロックを配置する
    When 次のブロックを配置する:
      """
      %block{:type => "character_new", :x => "21", :y => "15"}
        %field{:name => "NAME"}<
          car1
        %statement{:name => "DO"}
          %block{:type => "hardware_smalrubot_s1_led_turn_on_or_off", :x => "0", :y => "0"}
            %field{:name => "COLOUR"}<
              white
            %field{:name => "OOO"}<
              turn_off
      """
    And ブロックからソースコードを生成する

    Then テキストエディタのプログラムは以下であること:
      """
      require "smalruby"

      car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)
      car1.smalrubot_s1.turn_off_white_led

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
              %block{:type => "hardware_smalrubot_s1_led_turn_on_or_off", :x => "0", :y => "0"}
                %field{:name => "COLOUR"}<
                  blue
                %field{:name => "OOO"}<
                  turn_on
      """
    And ブロックからソースコードを生成する

    Then テキストエディタのプログラムは以下であること:
      """
      require "smalruby"

      car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

      car1.on(:start) do
        smalrubot_s1.turn_on_blue_led
      end

      """
