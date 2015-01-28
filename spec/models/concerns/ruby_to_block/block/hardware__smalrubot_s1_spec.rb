# -*- coding: utf-8 -*-
require 'spec_helper'
require_relative 'shared/block_examples'

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock::Block, 'Smalrubot S1 blocks', to_blocks: true do
  parts = <<-EOS
require "smalruby"

init_hardware
car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

car1.on(:start) do
  smalrubot_s1.forward
  smalrubot_s1.backward
  smalrubot_s1.turn_left
  smalrubot_s1.turn_right
  smalrubot_s1.stop

  smalrubot_s1.forward(sec: 0.5)
  smalrubot_s1.backward(sec: 0.4)
  smalrubot_s1.turn_left(sec: 0.3)
  smalrubot_s1.turn_right(sec: 0.2)
  smalrubot_s1.stop(sec: 0.1)

  p(smalrubot_s1.left_ir_photoreflector_value)
  p(smalrubot_s1.right_ir_photoreflector_value)

  smalrubot_s1.turn_on_white_led
  smalrubot_s1.turn_off_blue_led
end
car1.smalrubot_s1.forward
car1.smalrubot_s1.backward
car1.smalrubot_s1.turn_left
car1.smalrubot_s1.turn_right
car1.smalrubot_s1.stop

car1.smalrubot_s1.forward(sec: 0.5)
car1.smalrubot_s1.backward(sec: 0.4)
car1.smalrubot_s1.turn_left(sec: 0.3)
car1.smalrubot_s1.turn_right(sec: 0.2)
car1.smalrubot_s1.stop(sec: 0.1)

p(car1.smalrubot_s1.left_ir_photoreflector_value)
p(car1.smalrubot_s1.right_ir_photoreflector_value)

car1.smalrubot_s1.turn_on_white_led
car1.smalrubot_s1.turn_off_blue_led
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
          <block type="hardware_smalrubot_s1_action" inline="true">
            <field name="ACTION">forward</field>
            <next>
              <block type="hardware_smalrubot_s1_action" inline="true">
                <field name="ACTION">backward</field>
                <next>
                  <block type="hardware_smalrubot_s1_action" inline="true">
                    <field name="ACTION">turn_left</field>
                    <next>
                      <block type="hardware_smalrubot_s1_action" inline="true">
                        <field name="ACTION">turn_right</field>
                        <next>
                          <block type="hardware_smalrubot_s1_action" inline="true">
                            <field name="ACTION">stop</field>
                            <next>
                              <block type="hardware_smalrubot_s1_action_with_sec" inline="true">
                                <field name="ACTION">forward</field>
                                <value name="SEC">
                                  <block type="math_number">
                                    <field name="NUM">0.5</field>
                                  </block>
                                </value>
                                <next>
                                  <block type="hardware_smalrubot_s1_action_with_sec" inline="true">
                                    <field name="ACTION">backward</field>
                                    <value name="SEC">
                                      <block type="math_number">
                                        <field name="NUM">0.4</field>
                                      </block>
                                    </value>
                                    <next>
                                      <block type="hardware_smalrubot_s1_action_with_sec" inline="true">
                                        <field name="ACTION">turn_left</field>
                                        <value name="SEC">
                                          <block type="math_number">
                                            <field name="NUM">0.3</field>
                                          </block>
                                        </value>
                                        <next>
                                          <block type="hardware_smalrubot_s1_action_with_sec" inline="true">
                                            <field name="ACTION">turn_right</field>
                                            <value name="SEC">
                                              <block type="math_number">
                                                <field name="NUM">0.2</field>
                                              </block>
                                            </value>
                                            <next>
                                              <block type="hardware_smalrubot_s1_action_with_sec" inline="true">
                                                <field name="ACTION">stop</field>
                                                <value name="SEC">
                                                  <block type="math_number">
                                                    <field name="NUM">0.1</field>
                                                  </block>
                                                </value>
                                                <next>
                                                  <block type="ruby_p" inline="true">
                                                    <value name="ARG">
                                                      <block type="hardware_smalrubot_s1_ir_photoreflector_value">
                                                        <field name="LOR">left</field>
                                                      </block>
                                                    </value>
                                                    <next>
                                                      <block type="ruby_p" inline="true">
                                                        <value name="ARG">
                                                          <block type="hardware_smalrubot_s1_ir_photoreflector_value">
                                                            <field name="LOR">right</field>
                                                          </block>
                                                        </value>
                                                        <next>
                                                          <block type="hardware_smalrubot_s1_led_turn_on_or_off" inline="true">
                                                            <field name="COLOUR">white</field>
                                                            <field name="OOO">turn_on</field>
                                                            <next>
                                                              <block type="hardware_smalrubot_s1_led_turn_on_or_off" inline="true">
                                                                <field name="COLOUR">blue</field>
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
        </statement>
        <next>
          <block type="hardware_smalrubot_s1_action" inline="true">
            <field name="ACTION">forward</field>
            <next>
              <block type="hardware_smalrubot_s1_action" inline="true">
                <field name="ACTION">backward</field>
                <next>
                  <block type="hardware_smalrubot_s1_action" inline="true">
                    <field name="ACTION">turn_left</field>
                    <next>
                      <block type="hardware_smalrubot_s1_action" inline="true">
                        <field name="ACTION">turn_right</field>
                        <next>
                          <block type="hardware_smalrubot_s1_action" inline="true">
                            <field name="ACTION">stop</field>
                            <next>
                              <block type="hardware_smalrubot_s1_action_with_sec" inline="true">
                                <field name="ACTION">forward</field>
                                <value name="SEC">
                                  <block type="math_number">
                                    <field name="NUM">0.5</field>
                                  </block>
                                </value>
                                <next>
                                  <block type="hardware_smalrubot_s1_action_with_sec" inline="true">
                                    <field name="ACTION">backward</field>
                                    <value name="SEC">
                                      <block type="math_number">
                                        <field name="NUM">0.4</field>
                                      </block>
                                    </value>
                                    <next>
                                      <block type="hardware_smalrubot_s1_action_with_sec" inline="true">
                                        <field name="ACTION">turn_left</field>
                                        <value name="SEC">
                                          <block type="math_number">
                                            <field name="NUM">0.3</field>
                                          </block>
                                        </value>
                                        <next>
                                          <block type="hardware_smalrubot_s1_action_with_sec" inline="true">
                                            <field name="ACTION">turn_right</field>
                                            <value name="SEC">
                                              <block type="math_number">
                                                <field name="NUM">0.2</field>
                                              </block>
                                            </value>
                                            <next>
                                              <block type="hardware_smalrubot_s1_action_with_sec" inline="true">
                                                <field name="ACTION">stop</field>
                                                <value name="SEC">
                                                  <block type="math_number">
                                                    <field name="NUM">0.1</field>
                                                  </block>
                                                </value>
                                                <next>
                                                  <block type="ruby_p" inline="true">
                                                    <value name="ARG">
                                                      <block type="hardware_smalrubot_s1_ir_photoreflector_value">
                                                        <field name="LOR">left</field>
                                                      </block>
                                                    </value>
                                                    <next>
                                                      <block type="ruby_p" inline="true">
                                                        <value name="ARG">
                                                          <block type="hardware_smalrubot_s1_ir_photoreflector_value">
                                                            <field name="LOR">right</field>
                                                          </block>
                                                        </value>
                                                        <next>
                                                          <block type="hardware_smalrubot_s1_led_turn_on_or_off" inline="true">
                                                            <field name="COLOUR">white</field>
                                                            <field name="OOO">turn_on</field>
                                                            <next>
                                                              <block type="hardware_smalrubot_s1_led_turn_on_or_off" inline="true">
                                                                <field name="COLOUR">blue</field>
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
    </statement>
  </block>
      XML
    end
  end
end
