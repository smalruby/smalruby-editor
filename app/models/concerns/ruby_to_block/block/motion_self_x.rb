module RubyToBlock
  module Block
    class MotionSelfX < Value
      include CharacterOperation

      blocknize '^\s*' + CHAR_RE + 'x\s*$',
                value: true

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])

        name = md2[1]
        name = context.receiver.try(:name) if !name || name == 'self'
        character = context.characters[name]
        fail unless character

        block = new
        context.add_value(block)
        block.character = character

        true
      end
    end
  end
end
