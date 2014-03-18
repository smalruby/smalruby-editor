# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class MotionMove < CharacterMethodCall
      blocknize '^\s*' + CHAR_RE + 'move\((.+)\)\s*$',
                statement: true, inline: true

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        add_character_method_call_block(context, md2[1], new, STEP: md2[2])
        true
      end
    end
  end
end
