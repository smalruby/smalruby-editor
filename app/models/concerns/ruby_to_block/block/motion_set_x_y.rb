# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class MotionSetXY < CharacterMethodCall
      blocknize '^\s*' + CHAR_RE +
                'position\s*=\s*\[\s*(\S+)\s*,\s*(\S+)\s*\]\s*$',
                statement: true, inline: true

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        add_character_method_call_block(context, md2[1], new,
                                        X: md2[2], Y: md2[3])
        true
      end

      def type
        'motion_set_x_y'
      end
    end
  end
end
