# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class HardwareTwoWheelDriveCarRun < CharacterMethodCall
      # rubocop:disable LineLength
      blocknize '^\s*' + CHAR_RE + 'two_wheel_drive_car\("(D(?:[2-9]|10))"\)\.run\(command:\s*("[^"]*")\s*,\s*sec:\s*(\d+)\)\s*$',
                statement: true, inline: true
      # rubocop:enable LineLength

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        add_character_method_call_block(context, md2[1],
                                        new(fields: { PIN: md2[2] }),
                                        SEC: md2[4], COMMAND: md2[3])
        true
      end
    end
  end
end
