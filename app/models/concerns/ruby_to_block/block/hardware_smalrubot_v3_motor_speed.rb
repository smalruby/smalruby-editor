module RubyToBlock
  module Block
    class HardwareSmalrubotV3MotorSpeed < Value
      include CharacterOperation
      include HardwareOperation

      blocknize '^\s*' + CHAR_RE +
                'smalrubot_v3\.' +
                LOR_RE + '_motor_speed\s*$',
                value: true

      def self.process_match_data(md, context)
        md2 = regexp.match(md[type])

        character = get_character(context, md2[1])
        return false if context.receiver && context.receiver != character

        block = new(fields: { LOR: md2[2] })
        context.add_value(block)
        block.character = character

        true
      end
    end
  end
end
