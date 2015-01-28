# encoding: utf-8
# language: en
@javascript
Feature: hardware_smalrubot_s1_action block
  Background:
    Given "ブロック" タブを表示する
    And キャラクターcar1を追加する

  Scenario: ブロックのみ配置する
    When 次のブロックを配置する:
      """
      %block{:type => "hardware_smalrubot_s1_action", :x => "0", :y => "0"}
        %field{:name => "ACTION"}<
          backward
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
          %block{:type => "hardware_smalrubot_s1_action", :x => "0", :y => "0"}
            %field{:name => "ACTION"}<
              forward
            %next
              %block{:type => "hardware_smalrubot_s1_action", :x => "0", :y => "0"}
                %field{:name => "ACTION"}<
                  backward
                %next
                  %block{:type => "hardware_smalrubot_s1_action", :x => "0", :y => "0"}
                    %field{:name => "ACTION"}<
                      turn_left
                    %next
                      %block{:type => "hardware_smalrubot_s1_action", :x => "0", :y => "0"}
                        %field{:name => "ACTION"}<
                          turn_right
                        %next
                          %block{:type => "hardware_smalrubot_s1_action", :x => "0", :y => "0"}
                            %field{:name => "ACTION"}<
                              stop
      """
    And ブロックからソースコードを生成する

    Then テキストエディタのプログラムは以下であること:
      """
      require "smalruby"

      car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)
      car1.smalrubot_s1.forward
      car1.smalrubot_s1.backward
      car1.smalrubot_s1.turn_left
      car1.smalrubot_s1.turn_right
      car1.smalrubot_s1.stop

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
              %block{:type => "hardware_smalrubot_s1_action", :x => "0", :y => "0"}
                %field{:name => "ACTION"}<
                  forward
                %next
                  %block{:type => "hardware_smalrubot_s1_action", :x => "0", :y => "0"}
                    %field{:name => "ACTION"}<
                      backward
                    %next
                      %block{:type => "hardware_smalrubot_s1_action", :x => "0", :y => "0"}
                        %field{:name => "ACTION"}<
                          turn_left
                        %next
                          %block{:type => "hardware_smalrubot_s1_action", :x => "0", :y => "0"}
                            %field{:name => "ACTION"}<
                              turn_right
                            %next
                              %block{:type => "hardware_smalrubot_s1_action", :x => "0", :y => "0"}
                                %field{:name => "ACTION"}<
                                  stop
      """
    And ブロックからソースコードを生成する

    Then テキストエディタのプログラムは以下であること:
      """
      require "smalruby"

      car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

      car1.on(:start) do
        smalrubot_s1.forward
        smalrubot_s1.backward
        smalrubot_s1.turn_left
        smalrubot_s1.turn_right
        smalrubot_s1.stop
      end

      """
