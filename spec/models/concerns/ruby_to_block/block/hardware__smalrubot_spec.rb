# -*- coding: utf-8 -*-
require 'spec_helper'
require_relative 'shared/block_examples'

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock::Block, 'Smalrubot blocks', to_blocks: true do
  %w(s1 v3).each do |smalrubot_version|
    describe smalrubot_version do
      parts = <<-EOS
require "smalruby"

init_hardware

car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

car1.on(:start) do
  smalrubot_#{smalrubot_version}.forward
  smalrubot_#{smalrubot_version}.backward
  smalrubot_#{smalrubot_version}.turn_left
  smalrubot_#{smalrubot_version}.turn_right
  smalrubot_#{smalrubot_version}.stop

  smalrubot_#{smalrubot_version}.forward(sec: 0.5)
  smalrubot_#{smalrubot_version}.backward(sec: 0.4)
  smalrubot_#{smalrubot_version}.turn_left(sec: 0.3)
  smalrubot_#{smalrubot_version}.turn_right(sec: 0.2)
  smalrubot_#{smalrubot_version}.stop(sec: 0.1)

  p(smalrubot_#{smalrubot_version}.left_sensor_value)
  p(smalrubot_#{smalrubot_version}.right_sensor_value)

  smalrubot_#{smalrubot_version}.turn_on_left_led
  smalrubot_#{smalrubot_version}.turn_off_right_led

  p(smalrubot_#{smalrubot_version}.left_dc_motor_power_ratio)
  p(smalrubot_#{smalrubot_version}.right_dc_motor_power_ratio)

  smalrubot_#{smalrubot_version}.left_dc_motor_power_ratio = 10
  smalrubot_#{smalrubot_version}.right_dc_motor_power_ratio = 90
end
car1.smalrubot_#{smalrubot_version}.forward
car1.smalrubot_#{smalrubot_version}.backward
car1.smalrubot_#{smalrubot_version}.turn_left
car1.smalrubot_#{smalrubot_version}.turn_right
car1.smalrubot_#{smalrubot_version}.stop

car1.smalrubot_#{smalrubot_version}.forward(sec: 0.5)
car1.smalrubot_#{smalrubot_version}.backward(sec: 0.4)
car1.smalrubot_#{smalrubot_version}.turn_left(sec: 0.3)
car1.smalrubot_#{smalrubot_version}.turn_right(sec: 0.2)
car1.smalrubot_#{smalrubot_version}.stop(sec: 0.1)

p(car1.smalrubot_#{smalrubot_version}.left_sensor_value)
p(car1.smalrubot_#{smalrubot_version}.right_sensor_value)

car1.smalrubot_#{smalrubot_version}.turn_on_left_led
car1.smalrubot_#{smalrubot_version}.turn_off_right_led

p(car1.smalrubot_#{smalrubot_version}.left_dc_motor_power_ratio)
p(car1.smalrubot_#{smalrubot_version}.right_dc_motor_power_ratio)

car1.smalrubot_#{smalrubot_version}.left_dc_motor_power_ratio = 10
car1.smalrubot_#{smalrubot_version}.right_dc_motor_power_ratio = 90
    EOS
      describe compact_source_code(parts) do
        _parts = parts
        let(:data) { _parts }

        it '結果が正しいこと' do
          should eq_block_xml(<<-XML)
  <character name="car1" x="0" y="0" angle="0" costumes="car1.png" />
  <block type="character_new">
    <field name="NAME">car1</field>
    <statement name="DO">
      <block type="events_on_start">
        <statement name="DO">
          <block type="hardware_smalrubot_#{smalrubot_version}_action" inline="true">
            <field name="ACTION">forward</field>
            <next>
              <block type="hardware_smalrubot_#{smalrubot_version}_action" inline="true">
                <field name="ACTION">backward</field>
                <next>
                  <block type="hardware_smalrubot_#{smalrubot_version}_action" inline="true">
                    <field name="ACTION">turn_left</field>
                    <next>
                      <block type="hardware_smalrubot_#{smalrubot_version}_action" inline="true">
                        <field name="ACTION">turn_right</field>
                        <next>
                          <block type="hardware_smalrubot_#{smalrubot_version}_action" inline="true">
                            <field name="ACTION">stop</field>
                            <next>
                              <block type="hardware_smalrubot_#{smalrubot_version}_action_with_sec" inline="true">
                                <field name="ACTION">forward</field>
                                <value name="SEC">
                                  <block type="math_number">
                                    <field name="NUM">0.5</field>
                                  </block>
                                </value>
                                <next>
                                  <block type="hardware_smalrubot_#{smalrubot_version}_action_with_sec" inline="true">
                                    <field name="ACTION">backward</field>
                                    <value name="SEC">
                                      <block type="math_number">
                                        <field name="NUM">0.4</field>
                                      </block>
                                    </value>
                                    <next>
                                      <block type="hardware_smalrubot_#{smalrubot_version}_action_with_sec" inline="true">
                                        <field name="ACTION">turn_left</field>
                                        <value name="SEC">
                                          <block type="math_number">
                                            <field name="NUM">0.3</field>
                                          </block>
                                        </value>
                                        <next>
                                          <block type="hardware_smalrubot_#{smalrubot_version}_action_with_sec" inline="true">
                                            <field name="ACTION">turn_right</field>
                                            <value name="SEC">
                                              <block type="math_number">
                                                <field name="NUM">0.2</field>
                                              </block>
                                            </value>
                                            <next>
                                              <block type="hardware_smalrubot_#{smalrubot_version}_action_with_sec" inline="true">
                                                <field name="ACTION">stop</field>
                                                <value name="SEC">
                                                  <block type="math_number">
                                                    <field name="NUM">0.1</field>
                                                  </block>
                                                </value>
                                                <next>
                                                  <block type="ruby_p" inline="true">
                                                    <value name="ARG">
                                                      <block type="hardware_smalrubot_#{smalrubot_version}_sensor_value">
                                                        <field name="LOR">left</field>
                                                      </block>
                                                    </value>
                                                    <next>
                                                      <block type="ruby_p" inline="true">
                                                        <value name="ARG">
                                                          <block type="hardware_smalrubot_#{smalrubot_version}_sensor_value">
                                                            <field name="LOR">right</field>
                                                          </block>
                                                        </value>
                                                        <next>
                                                          <block type="hardware_smalrubot_#{smalrubot_version}_led_turn_on_or_off" inline="true">
                                                            <field name="LOR">left</field>
                                                            <field name="OOO">turn_on</field>
                                                            <next>
                                                              <block type="hardware_smalrubot_#{smalrubot_version}_led_turn_on_or_off" inline="true">
                                                                <field name="LOR">right</field>
                                                                <field name="OOO">turn_off</field>
                                                                <next>
                                                                  <block type="ruby_p" inline="true">
                                                                    <value name="ARG">
                                                                      <block type="hardware_smalrubot_#{smalrubot_version}_dc_motor_power_ratio">
                                                                        <field name="LOR">left</field>
                                                                      </block>
                                                                    </value>
                                                                    <next>
                                                                      <block type="ruby_p" inline="true">
                                                                        <value name="ARG">
                                                                          <block type="hardware_smalrubot_#{smalrubot_version}_dc_motor_power_ratio">
                                                                            <field name="LOR">right</field>
                                                                          </block>
                                                                        </value>
                                                                        <next>
                                                                          <block type="hardware_smalrubot_#{smalrubot_version}_dc_motor_set_power_ratio" inline="true">
                                                                            <field name="LOR">left</field>
                                                                            <value name="SPEED">
                                                                              <block type="math_number">
                                                                                <field name="NUM">10</field>
                                                                              </block>
                                                                            </value>
                                                                            <next>
                                                                              <block type="hardware_smalrubot_#{smalrubot_version}_dc_motor_set_power_ratio" inline="true">
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
        </statement>
        <next>
          <block type="hardware_smalrubot_#{smalrubot_version}_action" inline="true">
            <field name="ACTION">forward</field>
            <next>
              <block type="hardware_smalrubot_#{smalrubot_version}_action" inline="true">
                <field name="ACTION">backward</field>
                <next>
                  <block type="hardware_smalrubot_#{smalrubot_version}_action" inline="true">
                    <field name="ACTION">turn_left</field>
                    <next>
                      <block type="hardware_smalrubot_#{smalrubot_version}_action" inline="true">
                        <field name="ACTION">turn_right</field>
                        <next>
                          <block type="hardware_smalrubot_#{smalrubot_version}_action" inline="true">
                            <field name="ACTION">stop</field>
                            <next>
                              <block type="hardware_smalrubot_#{smalrubot_version}_action_with_sec" inline="true">
                                <field name="ACTION">forward</field>
                                <value name="SEC">
                                  <block type="math_number">
                                    <field name="NUM">0.5</field>
                                  </block>
                                </value>
                                <next>
                                  <block type="hardware_smalrubot_#{smalrubot_version}_action_with_sec" inline="true">
                                    <field name="ACTION">backward</field>
                                    <value name="SEC">
                                      <block type="math_number">
                                        <field name="NUM">0.4</field>
                                      </block>
                                    </value>
                                    <next>
                                      <block type="hardware_smalrubot_#{smalrubot_version}_action_with_sec" inline="true">
                                        <field name="ACTION">turn_left</field>
                                        <value name="SEC">
                                          <block type="math_number">
                                            <field name="NUM">0.3</field>
                                          </block>
                                        </value>
                                        <next>
                                          <block type="hardware_smalrubot_#{smalrubot_version}_action_with_sec" inline="true">
                                            <field name="ACTION">turn_right</field>
                                            <value name="SEC">
                                              <block type="math_number">
                                                <field name="NUM">0.2</field>
                                              </block>
                                            </value>
                                            <next>
                                              <block type="hardware_smalrubot_#{smalrubot_version}_action_with_sec" inline="true">
                                                <field name="ACTION">stop</field>
                                                <value name="SEC">
                                                  <block type="math_number">
                                                    <field name="NUM">0.1</field>
                                                  </block>
                                                </value>
                                                <next>
                                                  <block type="ruby_p" inline="true">
                                                    <value name="ARG">
                                                      <block type="hardware_smalrubot_#{smalrubot_version}_sensor_value">
                                                        <field name="LOR">left</field>
                                                      </block>
                                                    </value>
                                                    <next>
                                                      <block type="ruby_p" inline="true">
                                                        <value name="ARG">
                                                          <block type="hardware_smalrubot_#{smalrubot_version}_sensor_value">
                                                            <field name="LOR">right</field>
                                                          </block>
                                                        </value>
                                                        <next>
                                                          <block type="hardware_smalrubot_#{smalrubot_version}_led_turn_on_or_off" inline="true">
                                                            <field name="LOR">left</field>
                                                            <field name="OOO">turn_on</field>
                                                            <next>
                                                              <block type="hardware_smalrubot_#{smalrubot_version}_led_turn_on_or_off" inline="true">
                                                                <field name="LOR">right</field>
                                                                <field name="OOO">turn_off</field>
                                                                <next>
                                                                  <block type="ruby_p" inline="true">
                                                                    <value name="ARG">
                                                                      <block type="hardware_smalrubot_#{smalrubot_version}_dc_motor_power_ratio">
                                                                        <field name="LOR">left</field>
                                                                      </block>
                                                                    </value>
                                                                    <next>
                                                                      <block type="ruby_p" inline="true">
                                                                        <value name="ARG">
                                                                          <block type="hardware_smalrubot_#{smalrubot_version}_dc_motor_power_ratio">
                                                                            <field name="LOR">right</field>
                                                                          </block>
                                                                        </value>
                                                                        <next>
                                                                          <block type="hardware_smalrubot_#{smalrubot_version}_dc_motor_set_power_ratio" inline="true">
                                                                            <field name="LOR">left</field>
                                                                            <value name="SPEED">
                                                                              <block type="math_number">
                                                                                <field name="NUM">10</field>
                                                                              </block>
                                                                            </value>
                                                                            <next>
                                                                              <block type="hardware_smalrubot_#{smalrubot_version}_dc_motor_set_power_ratio" inline="true">
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
    </statement>
  </block>
      XML
        end
      end
    end
  end
end
