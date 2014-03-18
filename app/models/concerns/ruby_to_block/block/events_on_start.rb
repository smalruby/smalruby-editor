module RubyToBlock
  module Block
    class EventsOnStart < CharacterEvent
      blocknize '^\s*' + CHAR_RE + 'on\(:start\)\s+do\s*$',
                statement: true, indent: true

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        add_character_event_blocks(context, md2[1], new)
        true
      end
    end
  end
end
