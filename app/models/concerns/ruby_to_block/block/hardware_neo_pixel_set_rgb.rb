# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class HardwareNeoPixelSetRgb < CharacterMethodCall
      include HardwareOperation

      # rubocop:disable LineLength
      blocknize ['^\s*',
                 CHAR_RE,
                 'neo_pixel',
                 '\(', PWM_PIN_RE, '\)',
                 '\.set\(color:',
                 '\s*\[(\d+),\s*(\d+),\s*(\d+)\]\s*',
                 '\)',
                 '\s*$'].join(''),
                statement: true
      # rubocop:enable LineLength

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])

        block = new(fields: { PIN: md2[2] })
        add_character_method_call_block(context, md2[1], block,
                                        RED: md2[3],
                                        GREEN: md2[4],
                                        BLUE: md2[5])
        true
      end
    end
  end
end
