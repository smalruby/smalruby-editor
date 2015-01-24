module RubyToBlock
  module Block
    class HardwareSmalrubotV3TouchSensorPressedOrReleased < Value
      include CharacterOperation
      include HardwareOperation

      # rubocop:disable LineLength
      blocknize '^\s*' + CHAR_RE +
                'smalrubot_v3\.' +
                LOR_RE + '_touch_sensor\.' + POR_RE + '\?' +
                '\s*$',
                value: true
      # rubocop:enable LineLength

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])

        character = get_character(context, md2[1])
        return false if context.receiver && context.receiver != character

        block = new(fields: { LOR: md2[2], POR: md2[3] })
        context.add_value(block)
        block.character = character

        true
      end
    end
  end
end
