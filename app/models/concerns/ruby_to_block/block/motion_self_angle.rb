module RubyToBlock
  module Block
    class MotionSelfAngle < Value
      include CharacterOperation

      blocknize '^\s*' + CHAR_RE + 'angle\s*$',
                value: true

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])

        character = get_character(context, md2[1])
        return false if context.receiver != character

        block = new
        context.add_value(block)
        block.character = character

        true
      end
    end
  end
end
