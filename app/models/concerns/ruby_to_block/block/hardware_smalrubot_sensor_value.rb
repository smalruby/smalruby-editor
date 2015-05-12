module RubyToBlock
  module Block
    class HardwareSmalrubotSensorValue < Value
      include CharacterOperation
      include HardwareOperation

      # rubocop:disable LineLength
      blocknize ['^\s*',
                 CHAR_RE,
                 SMALRUBOT_RE, '.',
                 LOR_RE, '_sensor_value',
                 '\s*$'].join(''),
                value: true
      # rubocop:enable LineLength

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])

        character = get_character(context, md2[1])
        return false if context.receiver && context.receiver != character

        block = new(fields: { LOR: md2[3] })
        block.smalrubot_name = md2[2]
        context.add_value(block)
        block.character = character

        true
      end
    end
  end
end
