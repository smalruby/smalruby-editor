# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class HardwareMotorDriverSetSpeed < CharacterMethodCall
      # rubocop:disable LineLength
      blocknize '^\s*' + CHAR_RE +
                'motor_driver\("(D(?:3|5|6|9|10|11))"\)\.speed\s*=\s*(\S+)\s*$',
                statement: true, inline: true
      # rubocop:enable LineLength

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        add_character_method_call_block(context, md2[1],
                                        new(fields: { PIN: md2[2] }),
                                        SPEED: md2[3])
        true
      end
    end
  end
end
