# -*- coding: utf-8 -*-
require 'spec_helper'
require_relative 'shared/block_examples'

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock::Block, 'ハードウェアジャンル', to_blocks: true do
  parts = <<-EOS
require "smalruby"

init_hardware
car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

car1.on(:start) do
  led("D4").on
  rgb_led_cathode("D9").on(color: [255, 0, 0])
  two_wheel_drive_car("D6").forward
end
car1.led("D4").off
car1.rgb_led_cathode("D9").off
car1.two_wheel_drive_car("D6").backward

car1.on(:sensor_change, "A0") do
  if sensor("A0").value < 200
    two_wheel_drive_car("D6").turn_left
    two_wheel_drive_car("D6").turn_right
    two_wheel_drive_car("D6").stop
    two_wheel_drive_car("D6").run(command: "forward", sec: 1)
    two_wheel_drive_car("D6").run(command: "backward", sec: 2)
    two_wheel_drive_car("D6").run(command: "turn_left", sec: 3)
    two_wheel_drive_car("D6").run(command: "turn_right", sec: 4)
    two_wheel_drive_car("D6").run(command: "stop", sec: 5)
  end
end
  EOS
  describe compact_source_code(parts) do
    _parts = parts
    let(:data) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
  <character name="car1" x="0" y="0" angle="0" costumes="car1.png" />
  <block type="hardware_init_hardware" />
  <block type="character_new">
    <field name="NAME">car1</field>
    <statement name="DO">
      <block type="events_on_start">
        <statement name="DO">
          <block type="hardware_led_on">
            <field name="PIN">D4</field>
            <next>
              <block type="hardware_rgb_led_on">
                <field name="AC">cathode</field>
                <field name="PIN">D9</field>
                <field name="COLOUR">#ff0000</field>
                <next>
                  <block type="hardware_two_wheel_drive_car_forward">
                    <field name="PIN">D6</field>
                  </block>
                </next>
              </block>
            </next>
          </block>
        </statement>
        <next>
          <block type="hardware_led_off">
            <field name="PIN">D4</field>
            <next>
              <block type="hardware_rgb_led_off">
                <field name="AC">cathode</field>
                <field name="PIN">D9</field>
                <next>
                  <block type="hardware_two_wheel_drive_car_backward">
                    <field name="PIN">D6</field>
                    <next>
                      <block type="hardware_on_sensor_change">
                        <field name="PIN">A0</field>
                        <statement name="DO">
                          <block type="control_if" inline="true">
                            <value name="COND">
                              <block type="operators_compare_lt" inline="true">
                                <value name="A">
                                  <block type="hardware_sensor_value">
                                    <field name="PIN">A0</field>
                                  </block>
                                </value>
                                <value name="B">
                                  <block type="math_number">
                                    <field name="NUM">200</field>
                                  </block>
                                </value>
                              </block>
                            </value>
                            <statement name="THEN">
                              <block type="hardware_two_wheel_drive_car_turn_left">
                                <field name="PIN">D6</field>
                                <next>
                                  <block type="hardware_two_wheel_drive_car_turn_right">
                                    <field name="PIN">D6</field>
                                    <next>
                                      <block type="hardware_two_wheel_drive_car_stop">
                                        <field name="PIN">D6</field>
                                        <next>
                                          <block type="hardware_two_wheel_drive_car_run" inline="true">
                                            <field name="PIN">D6</field>
                                            <value name="SEC">
                                              <block type="math_number">
                                                <field name="NUM">1</field>
                                              </block>
                                            </value>
                                            <value name="COMMAND">
                                              <block type="hardware_two_wheel_drive_car_commands">
                                                <field name="COMMAND">forward</field>
                                              </block>
                                            </value>
                                            <next>
                                              <block type="hardware_two_wheel_drive_car_run" inline="true">
                                                <field name="PIN">D6</field>
                                                <value name="SEC">
                                                  <block type="math_number">
                                                    <field name="NUM">2</field>
                                                  </block>
                                                </value>
                                                <value name="COMMAND">
                                                  <block type="hardware_two_wheel_drive_car_commands">
                                                    <field name="COMMAND">backward</field>
                                                  </block>
                                                </value>
                                                <next>
                                                  <block type="hardware_two_wheel_drive_car_run" inline="true">
                                                    <field name="PIN">D6</field>
                                                    <value name="SEC">
                                                      <block type="math_number">
                                                        <field name="NUM">3</field>
                                                      </block>
                                                    </value>
                                                    <value name="COMMAND">
                                                      <block type="hardware_two_wheel_drive_car_commands">
                                                        <field name="COMMAND">turn_left</field>
                                                      </block>
                                                    </value>
                                                    <next>
                                                      <block type="hardware_two_wheel_drive_car_run" inline="true">
                                                        <field name="PIN">D6</field>
                                                        <value name="SEC">
                                                          <block type="math_number">
                                                            <field name="NUM">4</field>
                                                          </block>
                                                        </value>
                                                        <value name="COMMAND">
                                                          <block type="hardware_two_wheel_drive_car_commands">
                                                            <field name="COMMAND">turn_right</field>
                                                          </block>
                                                        </value>
                                                        <next>
                                                          <block type="hardware_two_wheel_drive_car_run" inline="true">
                                                            <field name="PIN">D6</field>
                                                            <value name="SEC">
                                                              <block type="math_number">
                                                                <field name="NUM">5</field>
                                                              </block>
                                                            </value>
                                                            <value name="COMMAND">
                                                              <block type="hardware_two_wheel_drive_car_commands">
                                                                <field name="COMMAND">stop</field>
                                                              </block>
                                                            </value>
                                                          </block>
                                                        </next>
                                                      </block>
                                                    </next>
                                                  </block>
                                                </next>
                                              </block>
                                            </next>
                                          </block>
                                        </next>
                                      </block>
                                    </next>
                                  </block>
                                </next>
                              </block>
                            </statement>
                          </block>
                        </statement>
                      </block>
                    </next>
                  </block>
                </next>
              </block>
            </next>
          </block>
        </next>
      </block>
    </statement>
  </block>
      XML
    end
  end

  parts = <<-EOS
require "smalruby"

init_hardware
car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

car1.on(:start) do
  motor_driver("D3").speed = 50
  p(motor_driver("D3").speed)
  motor_driver("D3").forward
  motor_driver("D3").backward
end
car1.motor_driver("D3").speed = 50
p(car1.motor_driver("D3").speed)
car1.motor_driver("D3").stop
  EOS
  describe compact_source_code(parts) do
    _parts = parts
    let(:data) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
  <character name="car1" x="0" y="0" angle="0" costumes="car1.png" />
  <block type="hardware_init_hardware" />
  <block type="character_new">
    <field name="NAME">car1</field>
    <statement name="DO">
      <block type="events_on_start">
        <statement name="DO">
          <block type="hardware_motor_driver_set_speed" inline="true">
            <field name="PIN">D3</field>
            <value name="SPEED">
              <block type="math_number">
                <field name="NUM">50</field>
              </block>
            </value>
            <next>
              <block type="ruby_p" inline="true">
                <value name="ARG">
                  <block type="hardware_motor_driver_speed">
                    <field name="PIN">D3</field>
                  </block>
                </value>
                <next>
                  <block type="hardware_motor_driver">
                    <field name="PIN">D3</field>
                    <field name="METHOD">forward</field>
                    <next>
                      <block type="hardware_motor_driver">
                        <field name="PIN">D3</field>
                        <field name="METHOD">backward</field>
                      </block>
                    </next>
                  </block>
                </next>
              </block>
            </next>
          </block>
        </statement>
        <next>
          <block type="hardware_motor_driver_set_speed" inline="true">
            <field name="PIN">D3</field>
            <value name="SPEED">
              <block type="math_number">
                <field name="NUM">50</field>
              </block>
            </value>
            <next>
              <block type="ruby_p" inline="true">
                <value name="ARG">
                  <block type="hardware_motor_driver_speed">
                    <field name="PIN">D3</field>
                  </block>
                </value>
                <next>
                  <block type="hardware_motor_driver">
                    <field name="PIN">D3</field>
                    <field name="METHOD">stop</field>
                  </block>
                </next>
              </block>
            </next>
          </block>
        </next>
      </block>
    </statement>
  </block>
      XML
    end
  end

  parts = <<-EOS
require "smalruby"

init_hardware
car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

car1.on(:start) do
  two_wheel_drive_car("D5").left_speed = 50
  p(two_wheel_drive_car("D5").left_speed)
  two_wheel_drive_car("D5").forward
  two_wheel_drive_car("D5").backward
end
car1.two_wheel_drive_car("D5").right_speed = 50
p(car1.two_wheel_drive_car("D5").right_speed)
car1.two_wheel_drive_car("D5").stop
  EOS
  describe compact_source_code(parts) do
    _parts = parts
    let(:data) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
  <character name="car1" x="0" y="0" angle="0" costumes="car1.png" />
  <block type="hardware_init_hardware" />
  <block type="character_new">
    <field name="NAME">car1</field>
    <statement name="DO">
      <block type="events_on_start">
        <statement name="DO">
          <block type="hardware_two_wheel_drive_car_set_speed" inline="true">
            <field name="PIN">D5</field>
            <field name="LOR">left</field>
            <value name="SPEED">
              <block type="math_number">
                <field name="NUM">50</field>
              </block>
            </value>
            <next>
              <block type="ruby_p" inline="true">
                <value name="ARG">
                  <block type="hardware_two_wheel_drive_car_speed">
                    <field name="PIN">D5</field>
                    <field name="LOR">left</field>
                  </block>
                </value>
                <next>
                  <block type="hardware_two_wheel_drive_car_forward">
                    <field name="PIN">D5</field>
                    <next>
                      <block type="hardware_two_wheel_drive_car_backward">
                        <field name="PIN">D5</field>
                      </block>
                    </next>
                  </block>
                </next>
              </block>
            </next>
          </block>
        </statement>
        <next>
          <block type="hardware_two_wheel_drive_car_set_speed" inline="true">
            <field name="PIN">D5</field>
            <field name="LOR">right</field>
            <value name="SPEED">
              <block type="math_number">
                <field name="NUM">50</field>
              </block>
            </value>
            <next>
              <block type="ruby_p" inline="true">
                <value name="ARG">
                  <block type="hardware_two_wheel_drive_car_speed">
                    <field name="PIN">D5</field>
                    <field name="LOR">right</field>
                  </block>
                </value>
                <next>
                  <block type="hardware_two_wheel_drive_car_stop">
                    <field name="PIN">D5</field>
                  </block>
                </next>
              </block>
            </next>
          </block>
        </next>
      </block>
    </statement>
  </block>
      XML
    end
  end

  parts = <<-EOS
require "smalruby"

init_hardware
car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

car1.on(:button_down, "D3") do
  p(button("D3").up?)
  p(button("D3").down?)
  button("D3").not_use_pullup
end
p(car1.button("D3").up?)
p(car1.button("D3").down?)
car1.button("D3").not_use_pullup
  EOS
  describe compact_source_code(parts) do
    _parts = parts
    let(:data) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
  <character name="car1" x="0" y="0" angle="0" costumes="car1.png" />
  <block type="hardware_init_hardware" />
  <block type="character_new">
    <field name="NAME">car1</field>
    <statement name="DO">
      <block type="hardware_on_button_down_or_up">
        <field name="PIN">D3</field>
        <field name="DOU">down</field>
        <statement name="DO">
          <block type="ruby_p" inline="true">
            <value name="ARG">
              <block type="hardware_button_down_or_up">
                <field name="PIN">D3</field>
                <field name="DOU">up</field>
              </block>
            </value>
            <next>
              <block type="ruby_p" inline="true">
                <value name="ARG">
                  <block type="hardware_button_down_or_up">
                    <field name="PIN">D3</field>
                    <field name="DOU">down</field>
                  </block>
                </value>
                <next>
                  <block type="hardware_button_not_use_pullup">
                    <field name="PIN">D3</field>
                  </block>
                </next>
              </block>
            </next>
          </block>
        </statement>
        <next>
          <block type="ruby_p" inline="true">
            <value name="ARG">
              <block type="hardware_button_down_or_up">
                <field name="PIN">D3</field>
                <field name="DOU">up</field>
              </block>
            </value>
            <next>
              <block type="ruby_p" inline="true">
                <value name="ARG">
                  <block type="hardware_button_down_or_up">
                    <field name="PIN">D3</field>
                    <field name="DOU">down</field>
                  </block>
                </value>
                <next>
                  <block type="hardware_button_not_use_pullup">
                    <field name="PIN">D3</field>
                  </block>
                </next>
              </block>
            </next>
          </block>
        </next>
      </block>
    </statement>
  </block>
      XML
    end
  end
end
