# encoding: utf-8
# language: en
@javascript
Feature: hardware_smalrubot_v3_action block
  Background:
    Given "ブロック" タブを表示する
    And キャラクターcar1を追加する

  Scenario: ブロックのみ配置する
    When 次のブロックを配置する:
      """
      %block{:type => "hardware_smalrubot_v3_action", :x => "0", :y => "0"}
        %field{:name => "ACTION"}<
          backward
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
          %block{:type => "hardware_smalrubot_v3_action", :x => "0", :y => "0"}
            %field{:name => "ACTION"}<
              forward
            %next
              %block{:type => "hardware_smalrubot_v3_action", :x => "0", :y => "0"}
                %field{:name => "ACTION"}<
                  backward
                %next
                  %block{:type => "hardware_smalrubot_v3_action", :x => "0", :y => "0"}
                    %field{:name => "ACTION"}<
                      turn_left
                    %next
                      %block{:type => "hardware_smalrubot_v3_action", :x => "0", :y => "0"}
                        %field{:name => "ACTION"}<
                          turn_right
                        %next
                          %block{:type => "hardware_smalrubot_v3_action", :x => "0", :y => "0"}
                            %field{:name => "ACTION"}<
                              stop
      """
    And ブロックからソースコードを生成する

    Then テキストエディタのプログラムは以下を含むこと:
      """
      car1.smalrubot_v3.forward
      car1.smalrubot_v3.backward
      car1.smalrubot_v3.turn_left
      car1.smalrubot_v3.turn_right
      car1.smalrubot_v3.stop
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
              %block{:type => "hardware_smalrubot_v3_action", :x => "0", :y => "0"}
                %field{:name => "ACTION"}<
                  forward
                %next
                  %block{:type => "hardware_smalrubot_v3_action", :x => "0", :y => "0"}
                    %field{:name => "ACTION"}<
                      backward
                    %next
                      %block{:type => "hardware_smalrubot_v3_action", :x => "0", :y => "0"}
                        %field{:name => "ACTION"}<
                          turn_left
                        %next
                          %block{:type => "hardware_smalrubot_v3_action", :x => "0", :y => "0"}
                            %field{:name => "ACTION"}<
                              turn_right
                            %next
                              %block{:type => "hardware_smalrubot_v3_action", :x => "0", :y => "0"}
                                %field{:name => "ACTION"}<
                                  stop
      """
    And ブロックからソースコードを生成する

    Then テキストエディタのプログラムは以下を含むこと:
      """
      car1.on(:start) do
        smalrubot_v3.forward
        smalrubot_v3.backward
        smalrubot_v3.turn_left
        smalrubot_v3.turn_right
        smalrubot_v3.stop
      end
      """
