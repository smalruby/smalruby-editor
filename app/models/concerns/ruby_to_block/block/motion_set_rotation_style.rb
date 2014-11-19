# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class MotionSetRotationStyle < CharacterMethodCall
      blocknize '^\s*' + CHAR_RE +
                'rotation_style\s*=\s*:(left_right|none|free)\s*$',
                statement: true, inline: true

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        add_character_method_call_block(context, md2[1],
                                        new(fields: { STYLE: md2[2] }))
        true
      end
    end
  end
end
