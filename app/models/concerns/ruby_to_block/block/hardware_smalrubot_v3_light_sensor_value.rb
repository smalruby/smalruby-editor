module RubyToBlock
  module Block
    class HardwareSmalrubotV3LightSensorValue < Value
      include CharacterOperation

      # rubocop:disable LineLength
      blocknize '^\s*' + CHAR_RE +
                'smalrubot_v3\.' +
                'light_sensor\.value' +
                '\s*$',
                value: true
      # rubocop:enable LineLength

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])

        character = get_character(context, md2[1])
        return false if context.receiver && context.receiver != character

        block = new
        context.add_value(block)
        block.character = character

        true
      end
    end
  end
end
