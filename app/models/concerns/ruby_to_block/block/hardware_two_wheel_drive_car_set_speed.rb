# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class HardwareTwoWheelDriveCarSetSpeed < CharacterMethodCall
      include HardwareOperation

      blocknize '^\s*' + CHAR_RE +
                'two_wheel_drive_car\(' + TWO_WHEEL_DRIVE_CAR_PIN_RE + '\)\.' +
                LOR_RE + '_speed\s*=\s*(\S+)\s*$',
                statement: true, inline: true

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        add_character_method_call_block(context, md2[1],
                                        new(fields: { PIN: md2[2],
                                                      LOR: md2[3] }),
                                        SPEED: md2[4])
        true
      end
    end
  end
end
