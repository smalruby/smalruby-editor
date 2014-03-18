module RubyToBlock
  module Block
    class HardwareOnSensorChange < CharacterEvent
      # rubocop:disable LineLength
      blocknize '^\s*' + CHAR_RE + 'on\(:sensor_change,\s*"(A[0-5])"\s*\)\s+do\s*$',
                statement: true, indent: true
      # rubocop:enable LineLength

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])
        add_character_event_blocks(context, md2[1],
                                   new(fields: { PIN: md2[2] }))
        true
      end
    end
  end
end
