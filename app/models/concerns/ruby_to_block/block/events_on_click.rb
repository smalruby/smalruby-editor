module RubyToBlock
  module Block
    class EventsOnClick < CharacterEvent
      blocknize '^\s*' + CHAR_RE + 'on\(:click\)\s+do\s*$',
                statement: true, indent: true

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        add_character_event_blocks(context, md2[1], new)
        true
      end
    end
  end
end
