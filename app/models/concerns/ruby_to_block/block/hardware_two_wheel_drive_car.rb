# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class HardwareTwoWheelDriveCar < CharacterMethodCall
      # rubocop:disable LineLength
      blocknize '^\s*' + CHAR_RE + 'two_wheel_drive_car\("(D(?:[2-9]|10))"\)\.(forward|backward|turn_left|turn_right|stop)\s*$',
                statement: true
      # rubocop:enable LineLength

      attr_accessor :method_name

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        block =
          add_character_method_call_block(context, md2[1],
                                          new(fields: { PIN: md2[2] }))
        block.method_name = md2[3]
        true
      end

      def type
        "hardware_two_wheel_drive_car_#{method_name}"
      end
    end
  end
end
