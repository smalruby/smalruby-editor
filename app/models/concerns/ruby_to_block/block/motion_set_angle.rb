# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class MotionSetAngle < CharacterMethodCall
      blocknize '^\s*' + CHAR_RE + 'angle\s*=\s*(\S+)\s*$',
                statement: true, inline: true

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        add_character_method_call_block(context, md2[1], new, ANGLE: md2[2])
        true
      end
    end
  end
end
