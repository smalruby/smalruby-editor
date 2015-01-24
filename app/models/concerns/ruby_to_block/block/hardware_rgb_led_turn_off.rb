# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class HardwareRgbLedTurnOff < CharacterMethodCall
      # rubocop:disable LineLength
      blocknize '^\s*' + CHAR_RE + 'rgb_led_(anode|cathode)\("(D[39])"\)\.turn_off\s*$',
                statement: true
      # rubocop:enable LineLength

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        block = new(fields: { AC: md2[2], PIN: md2[3] })
        add_character_method_call_block(context, md2[1], block)
        true
      end
    end
  end
end
