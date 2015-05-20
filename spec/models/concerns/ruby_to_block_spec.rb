# -*- coding: utf-8 -*-
require 'spec_helper'
require_relative 'ruby_to_block/block/shared/block_examples'

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock do
  describe '#to_blocks', to_blocks: true  do
    context '成功する場合' do
      _data = <<-EOS
require "smalruby"

car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

car1.on(:start) do
  loop do
    move(10)
    turn_if_reach_wall
  end
end
      EOS
      describe compact_source_code(_data) do
        __data = _data
        let(:data) { __data }

        it '結果が正しいこと' do
          should eq_block_xml(<<-XML)
  <character name="car1" x="0" y="0" angle="0" costumes="car1.png" />
  <block type="character_new">
    <field name="NAME">car1</field>
    <statement name="DO">
      <block type="events_on_start">
        <statement name="DO">
          <block type="control_loop">
            <statement name="DO">
              <block type="motion_move" inline="true">
                <value name="STEP">
                  <block type="math_number">
                    <field name="NUM">10</field>
                  </block>
                </value>
                <next>
                  <block type="motion_turn_if_reach_wall" />
                </next>
              </block>
            </statement>
          </block>
        </statement>
      </block>
    </statement>
  </block>
          XML
        end
      end

      _data = <<-EOS
require "smalruby"

car1 = Character.new(costume: "car2.png", x: 0, y: 0, angle: 0)
# 逃げる車

car1.on(:start) do
  loop do
    move(6)
    if reach_wall?
      turn
    end
  end
end

car1.on(:key_down, K_LEFT) do
  rotate(-15)
end

car1.on(:key_down, K_RIGHT) do
  rotate(15)
end
      EOS
      describe compact_source_code(_data) do
        __data = _data
        let(:data) { __data }

        it '結果が正しいこと' do
          should eq_block_xml(<<-XML)
  <character name="car1" x="0" y="0" angle="0" costumes="car2.png" />
  <block type="ruby_comment">
    <field name="COMMENT">逃げる車</field>
    <next>
      <block type="character_new">
        <field name="NAME">car1</field>
        <statement name="DO">
          <block type="events_on_start">
            <statement name="DO">
              <block type="control_loop">
                <statement name="DO">
                  <block type="motion_move" inline="true">
                    <value name="STEP">
                      <block type="math_number">
                        <field name="NUM">6</field>
                      </block>
                    </value>
                    <next>
                      <block type="control_if" inline="true">
                        <value name="COND">
                          <block type="sensing_reach_wall" />
                        </value>
                        <statement name="THEN">
                          <block type="motion_turn" />
                        </statement>
                      </block>
                    </next>
                  </block>
                </statement>
              </block>
            </statement>
            <next>
              <block type="events_on_key_push_or_down">
                <field name="KEY">K_LEFT</field>
                <field name="POD">down</field>
                <statement name="DO">
                  <block type="motion_rotate_left" inline="true">
                    <value name="ANGLE">
                      <block type="math_number">
                        <field name="NUM">15</field>
                      </block>
                    </value>
                  </block>
                </statement>
                <next>
                  <block type="events_on_key_push_or_down">
                    <field name="KEY">K_RIGHT</field>
                    <field name="POD">down</field>
                    <statement name="DO">
                      <block type="motion_rotate_right" inline="true">
                        <value name="ANGLE">
                          <block type="math_number">
                            <field name="NUM">15</field>
                          </block>
                        </value>
                      </block>
                    </statement>
                  </block>
                </next>
              </block>
            </next>
          </block>
        </statement>
      </block>
    </next>
  </block>
          XML
        end
      end

      _data = <<-EOS
require "smalruby"

car1 = Character.new(costume: "car2.png", x: 0, y: 0, angle: 0)
car2 = Character.new(costume: "car3.png", x: 0, y: 415, angle: 0)
# 追いかける車

car2.on(:start) do
  loop do
    point_towards(car1)
    move(3)
    if hit?(car1)
      say(message: "追いつきました！")
    else
      say(message: "")
    end
  end
end
      EOS
      describe compact_source_code(_data) do
        __data = _data
        let(:data) { __data }

        it '結果が正しいこと' do
          should eq_block_xml(<<-XML)
  <character name="car1" x="0" y="0" angle="0" costumes="car2.png" />
  <character name="car2" x="0" y="415" angle="0" costumes="car3.png" />
  <block type="ruby_comment">
    <field name="COMMENT">追いかける車</field>
    <next>
      <block type="character_new">
        <field name="NAME">car2</field>
        <statement name="DO">
          <block type="events_on_start">
            <statement name="DO">
              <block type="control_loop">
                <statement name="DO">
                  <block type="motion_point_towards_character">
                    <field name="CHAR">car1</field>
                    <next>
                      <block type="motion_move" inline="true">
                        <value name="STEP">
                          <block type="math_number">
                            <field name="NUM">3</field>
                          </block>
                        </value>
                        <next>
                          <block type="control_if_else" inline="true">
                            <value name="COND">
                              <block type="sensing_hit">
                                <field name="CHAR">car1</field>
                              </block>
                            </value>
                            <statement name="THEN">
                              <block type="looks_say" inline="true">
                                <value name="TEXT">
                                  <block type="text">
                                    <field name="TEXT">追いつきました！</field>
                                  </block>
                                </value>
                              </block>
                            </statement>
                            <statement name="ELSE">
                              <block type="looks_say" inline="true">
                                <value name="TEXT">
                                  <block type="text">
                                    <field name="TEXT"></field>
                                  </block>
                                </value>
                              </block>
                            </statement>
                          </block>
                        </next>
                      </block>
                    </next>
                  </block>
                </statement>
              </block>
            </statement>
          </block>
        </statement>
      </block>
    </next>
  </block>
          XML
        end
      end

      _data = <<-EOS
require "smalruby"

car1 = Character.new(costume: "car2.png", x: 0, y: 0, angle: 0)
car2 = Character.new(costume: "car3.png", x: 0, y: 415, angle: 0)
# 逃げる車

car1.on(:start) do
  loop do
    move(6)
    if reach_wall?
      turn
    end
  end
end

car1.on(:key_down, K_LEFT) do
  rotate(-15)
end

car1.on(:key_down, K_RIGHT) do
  rotate(15)
end

# 追いかける車

car2.on(:start) do
  loop do
    point_towards(car1)
    move(3)
    if hit?(car1)
      say(message: "追いつきました！")
    else
      say(message: "")
    end
  end
end
      EOS
      describe compact_source_code(_data) do
        __data = _data
        let(:data) { __data }

        it '結果が正しいこと' do
          should eq_block_xml(<<-XML)
  <character name="car1" x="0" y="0" angle="0" costumes="car2.png" />
  <character name="car2" x="0" y="415" angle="0" costumes="car3.png" />
  <block type="ruby_comment">
    <field name="COMMENT">逃げる車</field>
    <next>
      <block type="character_new">
        <field name="NAME">car1</field>
        <statement name="DO">
          <block type="events_on_start">
            <statement name="DO">
              <block type="control_loop">
                <statement name="DO">
                  <block type="motion_move" inline="true">
                    <value name="STEP">
                      <block type="math_number">
                        <field name="NUM">6</field>
                      </block>
                    </value>
                    <next>
                      <block type="control_if" inline="true">
                        <value name="COND">
                          <block type="sensing_reach_wall" />
                        </value>
                        <statement name="THEN">
                          <block type="motion_turn" />
                        </statement>
                      </block>
                    </next>
                  </block>
                </statement>
              </block>
            </statement>
            <next>
              <block type="events_on_key_push_or_down">
                <field name="KEY">K_LEFT</field>
                <field name="POD">down</field>
                <statement name="DO">
                  <block type="motion_rotate_left" inline="true">
                    <value name="ANGLE">
                      <block type="math_number">
                        <field name="NUM">15</field>
                      </block>
                    </value>
                  </block>
                </statement>
                <next>
                  <block type="events_on_key_push_or_down">
                    <field name="KEY">K_RIGHT</field>
                    <field name="POD">down</field>
                    <statement name="DO">
                      <block type="motion_rotate_right" inline="true">
                        <value name="ANGLE">
                          <block type="math_number">
                            <field name="NUM">15</field>
                          </block>
                        </value>
                      </block>
                    </statement>
                  </block>
                </next>
              </block>
            </next>
          </block>
        </statement>
        <next>
          <block type="ruby_comment">
            <field name="COMMENT">追いかける車</field>
            <next>
              <block type="character_new">
                <field name="NAME">car2</field>
                <statement name="DO">
                  <block type="events_on_start">
                    <statement name="DO">
                      <block type="control_loop">
                        <statement name="DO">
                          <block type="motion_point_towards_character">
                            <field name="CHAR">car1</field>
                            <next>
                              <block type="motion_move" inline="true">
                                <value name="STEP">
                                  <block type="math_number">
                                    <field name="NUM">3</field>
                                  </block>
                                </value>
                                <next>
                                  <block type="control_if_else" inline="true">
                                    <value name="COND">
                                      <block type="sensing_hit">
                                        <field name="CHAR">car1</field>
                                      </block>
                                    </value>
                                    <statement name="THEN">
                                      <block type="looks_say" inline="true">
                                        <value name="TEXT">
                                          <block type="text">
                                            <field name="TEXT">追いつきました！</field>
                                          </block>
                                        </value>
                                      </block>
                                    </statement>
                                    <statement name="ELSE">
                                      <block type="looks_say" inline="true">
                                        <value name="TEXT">
                                          <block type="text">
                                            <field name="TEXT"></field>
                                          </block>
                                        </value>
                                      </block>
                                    </statement>
                                  </block>
                                </next>
                              </block>
                            </next>
                          </block>
                        </statement>
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
          XML
        end
      end
    end

    _data = <<-EOS
require "smalruby"

init_hardware

frog1 = Character.new(costume: "frog1.png", x: 261, y: 191, angle: 0)

frog1.on(:click) do
  say(message: "ライトをぴかっとさせるでよ♪")
  rgb_led_anode("D3").color = [51, 51, 255]
  sleep(1)
  rgb_led_anode("D3").color = [255, 255, 153]
  sleep(1)
  rgb_led_anode("D3").color = [255, 0, 0]
  sleep(1)
  rgb_led_anode("D3").turn_off
  say(message: "")
end
    EOS
    describe compact_source_code(_data) do
      __data = _data
      let(:data) { __data }

      it '結果が正しいこと' do
        should eq_block_xml(<<-XML)
  <character name="frog1" x="261" y="191" angle="0" costumes="frog1.png" />
  <block type="character_new">
    <field name="NAME">frog1</field>
    <statement name="DO">
      <block type="events_on_click">
        <statement name="DO">
          <block type="looks_say" inline="true">
            <value name="TEXT">
              <block type="text">
                <field name="TEXT">ライトをぴかっとさせるでよ♪</field>
              </block>
            </value>
            <next>
              <block type="hardware_rgb_led_set_color">
                <field name="AC">anode</field>
                <field name="PIN">D3</field>
                <field name="COLOUR">#3333ff</field>
                <next>
                  <block type="control_sleep" inline="true">
                    <value name="SEC">
                      <block type="math_number">
                        <field name="NUM">1</field>
                      </block>
                    </value>
                    <next>
                      <block type="hardware_rgb_led_set_color">
                        <field name="AC">anode</field>
                        <field name="PIN">D3</field>
                        <field name="COLOUR">#ffff99</field>
                        <next>
                          <block type="control_sleep" inline="true">
                            <value name="SEC">
                              <block type="math_number">
                                <field name="NUM">1</field>
                              </block>
                            </value>
                            <next>
                              <block type="hardware_rgb_led_set_color">
                                <field name="AC">anode</field>
                                <field name="PIN">D3</field>
                                <field name="COLOUR">#ff0000</field>
                                <next>
                                  <block type="control_sleep" inline="true">
                                    <value name="SEC">
                                      <block type="math_number">
                                        <field name="NUM">1</field>
                                      </block>
                                    </value>
                                    <next>
                                      <block type="hardware_rgb_led_turn_off">
                                        <field name="AC">anode</field>
                                        <field name="PIN">D3</field>
                                        <next>
                                          <block type="looks_say" inline="true">
                                            <value name="TEXT">
                                              <block type="text">
                                                <field name="TEXT"></field>
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
        </statement>
      </block>
    </statement>
  </block>
        XML
      end
    end

    context '失敗する場合' do
      let(:data) { '__FAIL__' }

      it { expect { subject }.to raise_error }
    end
  end
end
