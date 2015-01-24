# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class HardwareLedTurnOn < CharacterMethodCall
      blocknize '^\s*' + CHAR_RE + 'led\("(D(?:[2-9]|1[0-3]))"\).turn_on\s*$',
                statement: true

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        add_character_method_call_block(context, md2[1],
                                        new(fields: { PIN: md2[2] }))
        true
      end
    end
  end
end
