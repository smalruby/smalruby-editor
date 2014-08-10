module RubyToBlock
  module Block
    class HardwareButtonNotUsePullup < CharacterMethodCall
      include HardwareOperation

      blocknize '^\s*' + CHAR_RE +
                'button\(' + DIO_PIN_RE + '\)\.not_use_pullup\s*$',
                statement: true

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        add_character_method_call_block(context, md2[1],
                                        new(fields: { PIN: md2[2] }))
        true
      end
    end
  end
end
