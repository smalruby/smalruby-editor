module RubyToBlock
  module Block
    class HardwareMotorDriverSpeed < Value
      include CharacterOperation

      blocknize '^\s*' + CHAR_RE +
                'motor_driver\("(D(?:3|5|6|9|10|11))"\)\.speed\s*$',
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
