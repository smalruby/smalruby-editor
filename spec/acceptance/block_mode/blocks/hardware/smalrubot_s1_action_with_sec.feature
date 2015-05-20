# encoding: utf-8
# language: en
@javascript
Feature: hardware_smalrubot_s1_action_with_sec block
  Background:
    Given "ブロック" タブを表示する
    And キャラクターcar1を追加する

  Scenario: ブロックのみ配置する
    When 次のブロックを配置する:
      """
      %block{:type => "hardware_smalrubot_s1_action_with_sec", :x => "0", :y => "0"}
        %field{:name => "ACTION"}<
          backward
        %value{:name => "SEC"}
          %block{:type => "math_number"}
            %field{:name => "NUM"}<
              0.5
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
          %block{:type => "hardware_smalrubot_s1_action_with_sec", :x => "0", :y => "0"}
            %field{:name => "ACTION"}<
              forward
            %value{:name => "SEC"}
              %block{:type => "math_number"}
                %field{:name => "NUM"}<
                  0.5
            %next
              %block{:type => "hardware_smalrubot_s1_action_with_sec", :x => "0", :y => "0"}
                %field{:name => "ACTION"}<
                  backward
                %value{:name => "SEC"}
                  %block{:type => "math_number"}
                    %field{:name => "NUM"}<
                      0.5
                %next
                  %block{:type => "hardware_smalrubot_s1_action_with_sec", :x => "0", :y => "0"}
                    %field{:name => "ACTION"}<
                      turn_left
                    %value{:name => "SEC"}
                      %block{:type => "math_number"}
                        %field{:name => "NUM"}<
                          0.5
                    %next
                      %block{:type => "hardware_smalrubot_s1_action_with_sec", :x => "0", :y => "0"}
                        %field{:name => "ACTION"}<
                          turn_right
                        %value{:name => "SEC"}
                          %block{:type => "math_number"}
                            %field{:name => "NUM"}<
                              0.5
                        %next
                          %block{:type => "hardware_smalrubot_s1_action_with_sec", :x => "0", :y => "0"}
                            %field{:name => "ACTION"}<
                              stop
                            %value{:name => "SEC"}
                              %block{:type => "math_number"}
                                %field{:name => "NUM"}<
                                  0.5
      """
    And ブロックからソースコードを生成する

    Then テキストエディタのプログラムは以下を含むこと:
      """
      car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)
      car1.smalrubot_s1.forward(sec: 0.5)
      car1.smalrubot_s1.backward(sec: 0.5)
      car1.smalrubot_s1.turn_left(sec: 0.5)
      car1.smalrubot_s1.turn_right(sec: 0.5)
      car1.smalrubot_s1.stop(sec: 0.5)
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
              %block{:type => "hardware_smalrubot_s1_action_with_sec", :x => "0", :y => "0"}
                %field{:name => "ACTION"}<
                  forward
                %value{:name => "SEC"}
                  %block{:type => "math_number"}
                    %field{:name => "NUM"}<
                      0.5
                %next
                  %block{:type => "hardware_smalrubot_s1_action_with_sec", :x => "0", :y => "0"}
                    %field{:name => "ACTION"}<
                      backward
                    %value{:name => "SEC"}
                      %block{:type => "math_number"}
                        %field{:name => "NUM"}<
                          0.5
                    %next
                      %block{:type => "hardware_smalrubot_s1_action_with_sec", :x => "0", :y => "0"}
                        %field{:name => "ACTION"}<
                          turn_left
                        %value{:name => "SEC"}
                          %block{:type => "math_number"}
                            %field{:name => "NUM"}<
                              0.5
                        %next
                          %block{:type => "hardware_smalrubot_s1_action_with_sec", :x => "0", :y => "0"}
                            %field{:name => "ACTION"}<
                              turn_right
                            %value{:name => "SEC"}
                              %block{:type => "math_number"}
                                %field{:name => "NUM"}<
                                  0.5
                            %next
                              %block{:type => "hardware_smalrubot_s1_action_with_sec", :x => "0", :y => "0"}
                                %field{:name => "ACTION"}<
                                  stop
                                %value{:name => "SEC"}
                                  %block{:type => "math_number"}
                                    %field{:name => "NUM"}<
                                      0.5
      """
    And ブロックからソースコードを生成する

    Then テキストエディタのプログラムは以下を含むこと:
      """
      car1.on(:start) do
        smalrubot_s1.forward(sec: 0.5)
        smalrubot_s1.backward(sec: 0.5)
        smalrubot_s1.turn_left(sec: 0.5)
        smalrubot_s1.turn_right(sec: 0.5)
        smalrubot_s1.stop(sec: 0.5)
      end
      """
