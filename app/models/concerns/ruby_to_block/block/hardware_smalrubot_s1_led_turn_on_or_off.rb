# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class HardwareSmalrubotS1LedTurnOnOrOff < CharacterMethodCall
      include HardwareOperation

      # rubocop:disable LineLength
      blocknize '^\s*' + CHAR_RE +
                'smalrubot_s1\.(turn_on|turn_off)_(blue|white)_led' +
                '\s*$',
                statement: true, inline: true
      # rubocop:enable LineLength

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        block = new(fields: { COLOUR: md2[3], OOO: md2[2] })
        add_character_method_call_block(context, md2[1], block)
        true
      end
    end
  end
end
