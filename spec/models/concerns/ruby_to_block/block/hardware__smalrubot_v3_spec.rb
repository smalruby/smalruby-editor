# -*- coding: utf-8 -*-
require 'spec_helper'
require_relative 'shared/block_examples'

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock::Block, 'Smalrubot v3 blocks', to_blocks: true do
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

  p(smalrubot_v3.left_motor_speed)
  p(smalrubot_v3.right_motor_speed)

  smalrubot_v3.left_motor_speed = 10
  smalrubot_v3.right_motor_speed = 90
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

p(car1.smalrubot_v3.left_motor_speed)
p(car1.smalrubot_v3.right_motor_speed)

car1.smalrubot_v3.left_motor_speed = 10
car1.smalrubot_v3.right_motor_speed = 90
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
                                                                            <next>
                                                                              <block type="ruby_p" inline="true">
                                                                                <value name="ARG">
                                                                                  <block type="hardware_smalrubot_v3_motor_speed">
                                                                                    <field name="LOR">left</field>
                                                                                  </block>
                                                                                </value>
                                                                                <next>
                                                                                  <block type="ruby_p" inline="true">
                                                                                    <value name="ARG">
                                                                                      <block type="hardware_smalrubot_v3_motor_speed">
                                                                                        <field name="LOR">right</field>
                                                                                      </block>
                                                                                    </value>
                                                                                    <next>
                                                                                      <block type="hardware_smalrubot_v3_motor_set_speed" inline="true">
                                                                                        <field name="LOR">left</field>
                                                                                        <value name="SPEED">
                                                                                          <block type="math_number">
                                                                                            <field name="NUM">10</field>
                                                                                          </block>
                                                                                        </value>
                                                                                        <next>
                                                                                          <block type="hardware_smalrubot_v3_motor_set_speed" inline="true">
                                                                                            <field name="LOR">right</field>
                                                                                            <value name="SPEED">
                                                                                              <block type="math_number">
                                                                                                <field name="NUM">90</field>
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
                                                                            <next>
                                                                              <block type="ruby_p" inline="true">
                                                                                <value name="ARG">
                                                                                  <block type="hardware_smalrubot_v3_motor_speed">
                                                                                    <field name="LOR">left</field>
                                                                                  </block>
                                                                                </value>
                                                                                <next>
                                                                                  <block type="ruby_p" inline="true">
                                                                                    <value name="ARG">
                                                                                      <block type="hardware_smalrubot_v3_motor_speed">
                                                                                        <field name="LOR">right</field>
                                                                                      </block>
                                                                                    </value>
                                                                                    <next>
                                                                                      <block type="hardware_smalrubot_v3_motor_set_speed" inline="true">
                                                                                        <field name="LOR">left</field>
                                                                                        <value name="SPEED">
                                                                                          <block type="math_number">
                                                                                            <field name="NUM">10</field>
                                                                                          </block>
                                                                                        </value>
                                                                                        <next>
                                                                                          <block type="hardware_smalrubot_v3_motor_set_speed" inline="true">
                                                                                            <field name="LOR">right</field>
                                                                                            <value name="SPEED">
                                                                                              <block type="math_number">
                                                                                                <field name="NUM">90</field>
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
