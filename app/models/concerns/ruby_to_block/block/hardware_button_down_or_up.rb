module RubyToBlock
  module Block
    class HardwareButtonDownOrUp < Value
      include CharacterOperation
      include HardwareOperation

      blocknize '^\s*' + CHAR_RE +
                'button\(' + DIO_PIN_RE + '\)\.(down|up)\?\s*$',
                value: true

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])

        character = get_character(context, md2[1])
        return false if context.receiver && context.receiver != character

        block = new(fields: { PIN: md2[2], DOU: md2[3] })
        context.add_value(block)
        block.character = character

        true
      end
    end
  end
end
