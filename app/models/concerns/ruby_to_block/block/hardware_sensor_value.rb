module RubyToBlock
  module Block
    class HardwareSensorValue < Value
      include CharacterOperation

      blocknize '^\s*' + CHAR_RE + 'sensor\(\s*"(A[0-5])"\s*\)\.value\s*$',
                value: true

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])

        character = get_character(context, md2[1])
        return false if context.receiver != character

        block = new(fields: { PIN: md2[2] })
        context.add_value(block)
        block.character = character

        true
      end
    end
  end
end
