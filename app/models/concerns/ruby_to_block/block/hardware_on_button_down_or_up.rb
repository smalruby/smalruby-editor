module RubyToBlock
  module Block
    class HardwareOnButtonDownOrUp < CharacterEvent
      include HardwareOperation

      blocknize '^\s*' + CHAR_RE +
                'on\(:button_(down|up),' + DIO_PIN_RE + '\)\s+' +
                'do\s*$',
                statement: true, indent: true

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        add_character_event_blocks(context, md2[1],
                                   new(fields: { PIN: md2[3], DOU: md2[2] }))
        true
      end
    end
  end
end
