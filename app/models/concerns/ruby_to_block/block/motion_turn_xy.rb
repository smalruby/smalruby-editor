# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class MotionTurnXy < CharacterMethodCall
      blocknize '^\s*' + CHAR_RE + 'turn_([xy])\s*$', statement: true

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        add_character_method_call_block(context, md2[1],
                                        new(fields: { XY: md2[2] }))
        true
      end
    end
  end
end
