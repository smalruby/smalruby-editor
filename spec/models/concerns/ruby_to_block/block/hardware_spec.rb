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
  led("D4").turn_on
  rgb_led_cathode("D9").color = [255, 0, 0]
  two_wheel_drive_car("D6").forward
end
car1.led("D4").turn_off
car1.rgb_led_cathode("D9").turn_off
car1.two_wheel_drive_car("D6").backward

car1.on(:start) do
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
          <block type="hardware_led_turn_on">
            <field name="PIN">D4</field>
            <next>
              <block type="hardware_rgb_led_set_color">
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
          <block type="hardware_led_turn_off">
            <field name="PIN">D4</field>
            <next>
              <block type="hardware_rgb_led_turn_off">
                <field name="AC">cathode</field>
                <field name="PIN">D9</field>
                <next>
                  <block type="hardware_two_wheel_drive_car_backward">
                    <field name="PIN">D6</field>
                    <next>
                      <block type="events_on_start">
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

car1.on(:start) do
  p(button("D3").released?)
  p(button("D3").pressed?)
end
p(car1.button("D3").released?)
p(car1.button("D3").pressed?)
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
          <block type="ruby_p" inline="true">
            <value name="ARG">
              <block type="hardware_button_pressed_or_released">
                <field name="PIN">D3</field>
                <field name="POR">released</field>
              </block>
            </value>
            <next>
              <block type="ruby_p" inline="true">
                <value name="ARG">
                  <block type="hardware_button_pressed_or_released">
                    <field name="PIN">D3</field>
                    <field name="POR">pressed</field>
                  </block>
                </value>
              </block>
            </next>
          </block>
        </statement>
        <next>
          <block type="ruby_p" inline="true">
            <value name="ARG">
              <block type="hardware_button_pressed_or_released">
                <field name="PIN">D3</field>
                <field name="POR">released</field>
              </block>
            </value>
            <next>
              <block type="ruby_p" inline="true">
                <value name="ARG">
                  <block type="hardware_button_pressed_or_released">
                    <field name="PIN">D3</field>
                    <field name="POR">pressed</field>
                  </block>
                </value>
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
  smalrubot_v3.forward
  smalrubot_v3.backward
  smalrubot_v3.turn_left
  smalrubot_v3.turn_right
  smalrubot_v3.stop

  smalrubot_v3.forward(sec: 0.5)
  smalrubot_v3.backward(sec: 0.4)
  smalrubot_v3.turn_left(sec: 0.3)
  smalrubot_v3.turn_right(sec: 0.2)
  smalrubot_v3.stop(sec: 0.1)

  p(smalrubot_v3.left_touch_sensor.pressed?)
  p(smalrubot_v3.left_touch_sensor.released?)
  p(smalrubot_v3.right_touch_sensor.pressed?)
  p(smalrubot_v3.right_touch_sensor.released?)

  p(smalrubot_v3.light_sensor.value)

  smalrubot_v3.red_led.turn_on
  smalrubot_v3.green_led.turn_off
end
car1.smalrubot_v3.forward
car1.smalrubot_v3.backward
car1.smalrubot_v3.turn_left
car1.smalrubot_v3.turn_right
car1.smalrubot_v3.stop

car1.smalrubot_v3.forward(sec: 0.5)
car1.smalrubot_v3.backward(sec: 0.4)
car1.smalrubot_v3.turn_left(sec: 0.3)
car1.smalrubot_v3.turn_right(sec: 0.2)
car1.smalrubot_v3.stop(sec: 0.1)

p(car1.smalrubot_v3.left_touch_sensor.pressed?)
p(car1.smalrubot_v3.left_touch_sensor.released?)
p(car1.smalrubot_v3.right_touch_sensor.pressed?)
p(car1.smalrubot_v3.right_touch_sensor.released?)

p(car1.smalrubot_v3.light_sensor.value)

car1.smalrubot_v3.red_led.turn_on
car1.smalrubot_v3.green_led.turn_off
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
          <block type="hardware_smalrubot_v3_action" inline="true">
            <field name="ACTION">forward</field>
            <next>
              <block type="hardware_smalrubot_v3_action" inline="true">
                <field name="ACTION">backward</field>
                <next>
                  <block type="hardware_smalrubot_v3_action" inline="true">
                    <field name="ACTION">turn_left</field>
                    <next>
                      <block type="hardware_smalrubot_v3_action" inline="true">
                        <field name="ACTION">turn_right</field>
                        <next>
                          <block type="hardware_smalrubot_v3_action" inline="true">
                            <field name="ACTION">stop</field>
                            <next>
                              <block type="hardware_smalrubot_v3_action_with_sec" inline="true">
                                <field name="ACTION">forward</field>
                                <value name="SEC">
                                  <block type="math_number">
                                    <field name="NUM">0.5</field>
                                  </block>
                                </value>
                                <next>
                                  <block type="hardware_smalrubot_v3_action_with_sec" inline="true">
                                    <field name="ACTION">backward</field>
                                    <value name="SEC">
                                      <block type="math_number">
                                        <field name="NUM">0.4</field>
                                      </block>
                                    </value>
                                    <next>
                                      <block type="hardware_smalrubot_v3_action_with_sec" inline="true">
                                        <field name="ACTION">turn_left</field>
                                        <value name="SEC">
                                          <block type="math_number">
                                            <field name="NUM">0.3</field>
                                          </block>
                                        </value>
                                        <next>
                                          <block type="hardware_smalrubot_v3_action_with_sec" inline="true">
                                            <field name="ACTION">turn_right</field>
                                            <value name="SEC">
                                              <block type="math_number">
                                                <field name="NUM">0.2</field>
                                              </block>
                                            </value>
                                            <next>
                                              <block type="hardware_smalrubot_v3_action_with_sec" inline="true">
                                                <field name="ACTION">stop</field>
                                                <value name="SEC">
                                                  <block type="math_number">
                                                    <field name="NUM">0.1</field>
                                                  </block>
                                                </value>
                                                <next>
                                                  <block type="ruby_p" inline="true">
                                                    <value name="ARG">
                                                      <block type="hardware_smalrubot_v3_touch_sensor_pressed_or_released">
                                                        <field name="LOR">left</field>
                                                        <field name="POR">pressed</field>
                                                      </block>
                                                    </value>
                                                    <next>
                                                      <block type="ruby_p" inline="true">
                                                        <value name="ARG">
                                                          <block type="hardware_smalrubot_v3_touch_sensor_pressed_or_released">
                                                            <field name="LOR">left</field>
                                                            <field name="POR">released</field>
                                                          </block>
                                                        </value>
                                                        <next>
                                                          <block type="ruby_p" inline="true">
                                                            <value name="ARG">
                                                              <block type="hardware_smalrubot_v3_touch_sensor_pressed_or_released">
                                                                <field name="LOR">right</field>
                                                                <field name="POR">pressed</field>
                                                              </block>
                                                            </value>
                                                            <next>
                                                              <block type="ruby_p" inline="true">
                                                                <value name="ARG">
                                                                  <block type="hardware_smalrubot_v3_touch_sensor_pressed_or_released">
                                                                    <field name="LOR">right</field>
                                                                    <field name="POR">released</field>
                                                                  </block>
                                                                </value>
                                                                <next>
                                                                  <block type="ruby_p" inline="true">
                                                                    <value name="ARG">
                                                                      <block type="hardware_smalrubot_v3_light_sensor_value" />
                                                                    </value>
                                                                    <next>
                                                                      <block type="hardware_smalrubot_v3_led_turn_on_or_off" inline="true">
                                                                        <field name="COLOUR">red</field>
                                                                        <field name="OOO">turn_on</field>
                                                                        <next>
                                                                          <block type="hardware_smalrubot_v3_led_turn_on_or_off" inline="true">
                                                                            <field name="COLOUR">green</field>
                                                                            <field name="OOO">turn_off</field>
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
                </next>
              </block>
            </next>
          </block>
        </statement>
        <next>
          <block type="hardware_smalrubot_v3_action" inline="true">
            <field name="ACTION">forward</field>
            <next>
              <block type="hardware_smalrubot_v3_action" inline="true">
                <field name="ACTION">backward</field>
                <next>
                  <block type="hardware_smalrubot_v3_action" inline="true">
                    <field name="ACTION">turn_left</field>
                    <next>
                      <block type="hardware_smalrubot_v3_action" inline="true">
                        <field name="ACTION">turn_right</field>
                        <next>
                          <block type="hardware_smalrubot_v3_action" inline="true">
                            <field name="ACTION">stop</field>
                            <next>
                              <block type="hardware_smalrubot_v3_action_with_sec" inline="true">
                                <field name="ACTION">forward</field>
                                <value name="SEC">
                                  <block type="math_number">
                                    <field name="NUM">0.5</field>
                                  </block>
                                </value>
                                <next>
                                  <block type="hardware_smalrubot_v3_action_with_sec" inline="true">
                                    <field name="ACTION">backward</field>
                                    <value name="SEC">
                                      <block type="math_number">
                                        <field name="NUM">0.4</field>
                                      </block>
                                    </value>
                                    <next>
                                      <block type="hardware_smalrubot_v3_action_with_sec" inline="true">
                                        <field name="ACTION">turn_left</field>
                                        <value name="SEC">
                                          <block type="math_number">
                                            <field name="NUM">0.3</field>
                                          </block>
                                        </value>
                                        <next>
                                          <block type="hardware_smalrubot_v3_action_with_sec" inline="true">
                                            <field name="ACTION">turn_right</field>
                                            <value name="SEC">
                                              <block type="math_number">
                                                <field name="NUM">0.2</field>
                                              </block>
                                            </value>
                                            <next>
                                              <block type="hardware_smalrubot_v3_action_with_sec" inline="true">
                                                <field name="ACTION">stop</field>
                                                <value name="SEC">
                                                  <block type="math_number">
                                                    <field name="NUM">0.1</field>
                                                  </block>
                                                </value>
                                                <next>
                                                  <block type="ruby_p" inline="true">
                                                    <value name="ARG">
                                                      <block type="hardware_smalrubot_v3_touch_sensor_pressed_or_released">
                                                        <field name="LOR">left</field>
                                                        <field name="POR">pressed</field>
                                                      </block>
                                                    </value>
                                                    <next>
                                                      <block type="ruby_p" inline="true">
                                                        <value name="ARG">
                                                          <block type="hardware_smalrubot_v3_touch_sensor_pressed_or_released">
                                                            <field name="LOR">left</field>
                                                            <field name="POR">released</field>
                                                          </block>
                                                        </value>
                                                        <next>
                                                          <block type="ruby_p" inline="true">
                                                            <value name="ARG">
                                                              <block type="hardware_smalrubot_v3_touch_sensor_pressed_or_released">
                                                                <field name="LOR">right</field>
                                                                <field name="POR">pressed</field>
                                                              </block>
                                                            </value>
                                                            <next>
                                                              <block type="ruby_p" inline="true">
                                                                <value name="ARG">
                                                                  <block type="hardware_smalrubot_v3_touch_sensor_pressed_or_released">
                                                                    <field name="LOR">right</field>
                                                                    <field name="POR">released</field>
                                                                  </block>
                                                                </value>
                                                                <next>
                                                                  <block type="ruby_p" inline="true">
                                                                    <value name="ARG">
                                                                      <block type="hardware_smalrubot_v3_light_sensor_value" />
                                                                    </value>
                                                                    <next>
                                                                      <block type="hardware_smalrubot_v3_led_turn_on_or_off" inline="true">
                                                                        <field name="COLOUR">red</field>
                                                                        <field name="OOO">turn_on</field>
                                                                        <next>
                                                                          <block type="hardware_smalrubot_v3_led_turn_on_or_off" inline="true">
                                                                            <field name="COLOUR">green</field>
                                                                            <field name="OOO">turn_off</field>
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
