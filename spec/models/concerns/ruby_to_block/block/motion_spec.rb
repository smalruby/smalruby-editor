# -*- coding: utf-8 -*-
require 'spec_helper'
require_relative 'shared/block_examples'

# rubocop:disable EmptyLines, LineLength

describe RubyToBlock::Block, '移動・回転ジャンル', to_blocks: true do
  parts = <<-EOS
car1.on(:start) do
  move(10)
  self.position = [0, 0]
  self.x += 10
  self.x = 0
  self.y += 10
  self.y = 0
  if x < 300
    if y < 300

    end
  end
end
car1.move(10)
car1.position = [0, 0]
car1.x += 10
car1.x = 0
car1.y += 10
car1.y = 0
  EOS
  describe compact_source_code(parts), character_new_data: true do
    _parts = parts
    let(:parts) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
    <field name="NAME">car1</field>
    <statement name="DO">
      <block type="events_on_start">
        <statement name="DO">
          <block type="motion_move" inline="true">
            <value name="STEP">
              <block type="math_number">
                <field name="NUM">10</field>
              </block>
            </value>
            <next>
              <block type="motion_set_x_y" inline="true">
                <value name="X">
                  <block type="math_number">
                    <field name="NUM">0</field>
                  </block>
                </value>
                <value name="Y">
                  <block type="math_number">
                    <field name="NUM">0</field>
                  </block>
                </value>
                <next>
                  <block type="motion_change_x_by" inline="true">
                    <value name="X">
                      <block type="math_number">
                        <field name="NUM">10</field>
                      </block>
                    </value>
                    <next>
                      <block type="motion_set_x" inline="true">
                        <value name="X">
                          <block type="math_number">
                            <field name="NUM">0</field>
                          </block>
                        </value>
                        <next>
                          <block type="motion_change_y_by" inline="true">
                            <value name="Y">
                              <block type="math_number">
                                <field name="NUM">10</field>
                              </block>
                            </value>
                            <next>
                              <block type="motion_set_y" inline="true">
                                <value name="Y">
                                  <block type="math_number">
                                    <field name="NUM">0</field>
                                  </block>
                                </value>
                                <next>
                                  <block type="control_if" inline="true">
                                    <value name="COND">
                                      <block type="operators_compare_lt" inline="true">
                                        <value name="A">
                                          <block type="motion_self_x" />
                                        </value>
                                        <value name="B">
                                          <block type="math_number">
                                            <field name="NUM">300</field>
                                          </block>
                                        </value>
                                      </block>
                                    </value>
                                    <statement name="THEN">
                                      <block type="control_if" inline="true">
                                        <value name="COND">
                                          <block type="operators_compare_lt" inline="true">
                                            <value name="A">
                                              <block type="motion_self_y" />
                                            </value>
                                            <value name="B">
                                              <block type="math_number">
                                                <field name="NUM">300</field>
                                              </block>
                                            </value>
                                          </block>
                                        </value>
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
                </next>
              </block>
            </next>
          </block>
        </statement>
        <next>
          <block type="motion_move" inline="true">
            <value name="STEP">
              <block type="math_number">
                <field name="NUM">10</field>
              </block>
            </value>
            <next>
              <block type="motion_set_x_y" inline="true">
                <value name="X">
                  <block type="math_number">
                    <field name="NUM">0</field>
                  </block>
                </value>
                <value name="Y">
                  <block type="math_number">
                    <field name="NUM">0</field>
                  </block>
                </value>
                <next>
                  <block type="motion_change_x_by" inline="true">
                    <value name="X">
                      <block type="math_number">
                        <field name="NUM">10</field>
                      </block>
                    </value>
                    <next>
                      <block type="motion_set_x" inline="true">
                        <value name="X">
                          <block type="math_number">
                            <field name="NUM">0</field>
                          </block>
                        </value>
                        <next>
                          <block type="motion_change_y_by" inline="true">
                            <value name="Y">
                              <block type="math_number">
                                <field name="NUM">10</field>
                              </block>
                            </value>
                            <next>
                              <block type="motion_set_y" inline="true">
                                <value name="Y">
                                  <block type="math_number">
                                    <field name="NUM">0</field>
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
    </statement>
      XML
    end
  end

  parts = <<-EOS
car1.move(10)
car1.position = [0, 0]
car1.x += 10
  EOS
  describe compact_source_code(parts), character_new_data: true do
    _parts = parts
    let(:parts) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
    <field name="NAME">car1</field>
    <statement name="DO">
      <block type="motion_move" inline="true">
        <value name="STEP">
          <block type="math_number">
            <field name="NUM">10</field>
          </block>
        </value>
        <next>
          <block type="motion_set_x_y" inline="true">
            <value name="X">
              <block type="math_number">
                <field name="NUM">0</field>
              </block>
            </value>
            <value name="Y">
              <block type="math_number">
                <field name="NUM">0</field>
              </block>
            </value>
            <next>
              <block type="motion_change_x_by" inline="true">
                <value name="X">
                  <block type="math_number">
                    <field name="NUM">10</field>
                  </block>
                </value>
              </block>
            </next>
          </block>
        </next>
      </block>
    </statement>
      XML
    end
  end

  parts = <<-EOS
car1.on(:start) do
  turn_if_reach_wall
  if reach_wall?
    turn
  end
  rotate(15)
  rotate(-15)
  self.angle = 90
  point_towards(:mouse)
  point_towards(car1)
  if angle < 90

  end
end
car1.turn_if_reach_wall
car1.turn
car1.rotate(15)
car1.rotate(-15)
car1.angle = 90
car1.point_towards(:mouse)
car1.point_towards(car1)
  EOS
  describe compact_source_code(parts), character_new_data: true do
    _parts = parts
    let(:parts) { _parts }

    it '結果が正しいこと' do
      should eq_block_xml(<<-XML)
    <field name="NAME">car1</field>
    <statement name="DO">
      <block type="events_on_start">
        <statement name="DO">
          <block type="motion_turn_if_reach_wall">
            <next>
              <block type="control_if" inline="true">
                <value name="COND">
                  <block type="motion_reach_wall" />
                </value>
                <statement name="THEN">
                  <block type="motion_turn" />
                </statement>
                <next>
                  <block type="motion_rotate_right" inline="true">
                    <value name="ANGLE">
                      <block type="math_number">
                        <field name="NUM">15</field>
                      </block>
                    </value>
                    <next>
                      <block type="motion_rotate_left" inline="true">
                        <value name="ANGLE">
                          <block type="math_number">
                            <field name="NUM">15</field>
                          </block>
                        </value>
                        <next>
                          <block type="motion_set_angle" inline="true">
                            <value name="ANGLE">
                              <block type="math_number">
                                <field name="NUM">90</field>
                              </block>
                            </value>
                            <next>
                              <block type="motion_point_towards_mouse">
                                <next>
                                  <block type="motion_point_towards_character">
                                    <field name="CHAR">car1</field>
                                    <next>
                                      <block type="control_if" inline="true">
                                        <value name="COND">
                                          <block type="operators_compare_lt" inline="true">
                                            <value name="A">
                                              <block type="motion_self_angle" />
                                            </value>
                                            <value name="B">
                                              <block type="math_number">
                                                <field name="NUM">90</field>
                                              </block>
                                            </value>
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
        <next>
          <block type="motion_turn_if_reach_wall">
            <next>
              <block type="motion_turn">
                <next>
                  <block type="motion_rotate_right" inline="true">
                    <value name="ANGLE">
                      <block type="math_number">
                        <field name="NUM">15</field>
                      </block>
                    </value>
                    <next>
                      <block type="motion_rotate_left" inline="true">
                        <value name="ANGLE">
                          <block type="math_number">
                            <field name="NUM">15</field>
                          </block>
                        </value>
                        <next>
                          <block type="motion_set_angle" inline="true">
                            <value name="ANGLE">
                              <block type="math_number">
                                <field name="NUM">90</field>
                              </block>
                            </value>
                            <next>
                              <block type="motion_point_towards_mouse">
                                <next>
                                  <block type="motion_point_towards_character">
                                    <field name="CHAR">car1</field>
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
      XML
    end
  end
end
