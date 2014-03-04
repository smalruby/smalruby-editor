# -*- coding: utf-8 -*-
module RubyToBlock
  module Block
    class MotionPointTowardsCharacter < CharacterMethodCall
      blocknize '^\s*' + CHAR_RE + 'point_towards\(([^:)]+)\)\s*$',
                statement: true

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])

        name = md2[2]
        name.strip!
        c = context.characters[name]
        return false unless c

        block = new(fields: { CHAR: name })
        _, context.current_block =
          *add_child_or_create_character_new_block(context, md2[1], block)

        true
      end
    end
  end
end
