# encoding: utf-8
# language: en
@javascript
Feature: hardware_smalrubot_v3_dc_motor_{,set_}power_ratio block
  Background:
    Given "ブロック" タブを表示する
    And キャラクターcar1を追加する

  Scenario: ブロックのみ配置する
    When 次のブロックを配置する:
      """
      %block{:type => "hardware_smalrubot_v3_dc_motor_power_ratio"}
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
    When 次のブロックを配置する:
      """
      %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true" }
        %value{:name => "ARG"}
          %block{:type => "hardware_smalrubot_v3_dc_motor_power_ratio"}
            %field{:name => "LOR"}<
              right
        %next
          %block{:type => "hardware_smalrubot_v3_dc_motor_set_power_ratio"}
            %field{:name => "LOR"}<
              left
            %value{:name => "SPEED"}
              %block{:type => "math_number"}
                %field{:name => "NUM"}<
                  50
      """
    And ブロックからソースコードを生成する

    Then テキストエディタのプログラムは以下であること:
      """
      require "smalruby"

      init_hardware

      p("")

      """

  Scenario: キャラクターとブロックを配置する
    When 次のブロックを配置する:
      """
      %block{:type => "character_new", :x => "21", :y => "15"}
        %field{:name => "NAME"}<
          car1
        %statement{:name => "DO"}
          %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true" }
            %value{:name => "ARG"}
              %block{:type => "hardware_smalrubot_v3_dc_motor_power_ratio"}
                %field{:name => "LOR"}<
                  right
            %next
              %block{:type => "hardware_smalrubot_v3_dc_motor_set_power_ratio"}
                %field{:name => "LOR"}<
                  left
                %value{:name => "SPEED"}
                  %block{:type => "math_number"}
                    %field{:name => "NUM"}<
                      50
      """
    And ブロックからソースコードを生成する

    Then テキストエディタのプログラムは以下を含むこと:
      """
      p(car1.smalrubot_v3.right_dc_motor_power_ratio)
      car1.smalrubot_v3.left_dc_motor_power_ratio = 50
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
              %block{:type => "ruby_p", :x => "0", :y => "0", :inline => "true" }
                %value{:name => "ARG"}
                  %block{:type => "hardware_smalrubot_v3_dc_motor_power_ratio"}
                    %field{:name => "LOR"}<
                      right
                %next
                  %block{:type => "hardware_smalrubot_v3_dc_motor_set_power_ratio"}
                    %field{:name => "LOR"}<
                      left
                    %value{:name => "SPEED"}
                      %block{:type => "math_number"}
                        %field{:name => "NUM"}<
                          50
      """
    And ブロックからソースコードを生成する

    Then テキストエディタのプログラムは以下を含むこと:
      """
      car1.on(:start) do
        p(smalrubot_v3.right_dc_motor_power_ratio)
        self.smalrubot_v3.left_dc_motor_power_ratio = 50
      end
      """
